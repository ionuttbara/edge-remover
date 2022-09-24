pushd "%CD%"
CD /D "%~dp0"
@echo off
@title Microsoft Edge Uninstaller

		::Asks if user wants to make a backup or exit
		
		ECHO.
		ECHO ..................................................
		ECHO How do you want to start Microsoft Edge Uninstaller?
		ECHO ..................................................
		ECHO.
		ECHO Uninstall Microsoft Edge and create a system restore point (recommended) (q)
		ECHO Uninstall Microsoft Edge without creating system restore point (w)
		ECHO Exit Microsoft Edge Uninstaller (e)
		ECHO.

		SET /P M=Type the letter next to your option then press ENTER: 
		IF %M%==q goto startmsub
		IF %M%==w goto startmsu
		IF %M%==e (
			cls
			echo Leaving in 3s
			timeout /t 1 /nobreak >nul 
			cls
			echo Leaving in 2s
			timeout /t 1 /nobreak >nul
			cls
			echo Leaving in 1s
			timeout /t 1 /nobreak >nul
			exit /b
			::Countdown
			)
			
:startmsub
echo Checking if launched with administrative permissions (Needed to create system restore point)
    net session >nul 2>&1
    
    if %errorLevel% == 0 (
        echo Administrative Permissions detected, now creating system restore point.
        goto savebackup
    ) else (
        echo Failure: No administrative permissions. Please relaunch with Adnimistrative Permissions to create restore point.
        pause
        exit /b
    )
    
:savebackup
		cls
		echo Making backup, please wait!
		Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "This_was_made_by_Edge_Remover_on_%DATE%", 100, 1 
		echo Complete!
:startmsu
cd /d "%ProgramFiles(x86)%\Microsoft"
for /f "tokens=1 delims=\" %%i in ('dir /B /A:D "%ProgramFiles(x86)%\Microsoft\Edge\Application" ^| find "."') do (set "edge_chromium_package_version=%%i")
if defined edge_chromium_package_version (
		echo Removing %edge_chromium_package_version%...
		Edge\Application\%edge_chromium_package_version%\Installer\setup.exe --uninstall --force-uninstall --msedge --system-level --verbose-logging
		EdgeCore\%edge_chromium_package_version%\Installer\setup.exe --uninstall --force-uninstall --msedge --system-level --verbose-logging
	) else (
		echo Microsoft Edge [Chromium] not found, skipping.
	)
cd /d
for /f "tokens=8 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" ^| findstr "Microsoft-Windows-Internet-Browser-Package" ^| findstr "~~"') do (set "edge_legacy_package_version=%%i")
if defined edge_legacy_package_version (
		echo Removing %edge_legacy_package_version%...
		reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%edge_legacy_package_version%" /v Visibility /t REG_DWORD /d 1 /f
		reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%edge_legacy_package_version%\Owners" /va /f
		dism /online /Remove-Package /PackageName:%edge_legacy_package_version%
		powershell.exe -Command "Get-AppxPackage *edge* | Remove-AppxPackage" >nul
	) else (
		echo Microsoft Edge [Legacy/UWP] not found, skipping.
	)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1
cls
echo Script has finished, press any key to exit
pause >nul
exit /b
