pushd "%CD%"
CD /D "%~dp0"
@echo off
@title Microsoft Edge Uninstaller (with auto create system restore point)
    echo Checking if launched with administrative permissions (Needed to create system restore point)
    net session >nul 2>&1
    
    if %errorLevel% == 0 (
        echo Administrative Permissions detected, now creating system restore point.
        goto savebackup
    ) else (
        echo Failure: No administrative permissions. Leaving...
        pause
        exit
    )
    
:savebackup
		echo Making backup, please wait!
		Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "This_was_made_by_Edge_Remover_on_%DATE%", 100, 1
		
cd /d "%ProgramFiles(x86)%\Microsoft"
for /f "tokens=1 delims=\" %%i in ('dir /B /A:D "%ProgramFiles(x86)%\Microsoft\Edge\Application" ^| find "."') do (set "edge_chromium_package_version=%%i")
if defined edge_chromium_package_version (
		::Forces Edge's setup executable to uninstall itself
		echo Removing %edge_chromium_package_version%...
		EdgeWebView\Application\%edge_chromium_package_version%\Installer\setup.exe --uninstall --force-uninstall --msedgewebview --system-level --verbose-logging
		Edge\Application\%edge_chromium_package_version%\Installer\setup.exe --uninstall --force-uninstall --msedge --system-level --verbose-logging
		EdgeCore\%edge_chromium_package_version%\Installer\setup.exe --uninstall --force-uninstall --msedge --system-level --verbose-logging
	) else (
		echo Microsoft Edge [Chromium] not found, skipping.
	)
cd /d
for /f "tokens=8 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" ^| findstr "Microsoft-Windows-Internet-Browser-Package" ^| findstr "~~"') do (set "edge_legacy_package_version=%%i")
if defined edge_legacy_package_version (
		::Goes into registry and makes legacy edge invisible
		echo Removing %edge_legacy_package_version%...
		reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%edge_legacy_package_version%" /v Visibility /t REG_DWORD /d 1 /f
		reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%edge_legacy_package_version%\Owners" /va /f
		dism /online /Remove-Package /PackageName:%edge_legacy_package_version%
		powershell.exe -Command "Get-AppxPackage *edge* | Remove-AppxPackage" >nul
	) else (
		echo Microsoft Edge [Legacy/UWP] not found, skipping.
	)
echo Done. Press any key to exit.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1
pause >nul
exit /b
