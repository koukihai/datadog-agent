if not exist c:\mnt\ goto nomntdir

@echo c:\mnt found, continuing
@echo PARAMS %*

if NOT DEFINED RELEASE_VERSION set RELEASE_VERSION=nightly
if NOT DEFINED MAJOR_VERSION set MAJOR_VERSION=7

mkdir \dev\go\src\github.com\DataDog\datadog-agent 
if not exist \dev\go\src\github.com\DataDog\datadog-agent exit /b 1
cd \dev\go\src\github.com\DataDog\datadog-agent || exit /b 2
xcopy /e/s/h/q c:\mnt\*.* || exit /b 3
inv -e agent.version --major-version %MAJOR_VERSION%
inv -e deps --verbose --dep-vendor-only --no-checks || exit /b 4
inv -e agent.omnibus-build --skip-deps --major-version %MAJOR_VERSION% --release-version %RELEASE_VERSION% || exit /b 5

dir \omnibus\pkg

dir \omnibus-ruby\pkg\

if not exist c:\mnt\build-out mkdir c:\mnt\build-out || exit /b 6
copy \omnibus-ruby\pkg\*.msi c:\mnt\build-out || exit /b 7
if exist \omnibus-ruby\pkg\*.zip copy \omnibus-ruby\pkg\*.zip c:\mnt\build-out || exit /b 7

goto :EOF

:nomntdir
@echo directory not mounted, parameters incorrect
exit /b 1
goto :EOF