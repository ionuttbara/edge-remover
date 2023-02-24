@echo off
pushd "%CD%"
CD /D "%~dp0"
@title Microsoft Edge Uninstaller

		::Asks if user wants to make a backup or exit
		echo.
		echo ..................................................
		echo How do you want to start Microsoft Edge Uninstaller?
		echo ..................................................
		echo.
		echo Uninstall Microsoft Edge and create a system restore point (recommended) (q)
		echo Uninstall Microsoft Edge without creating system restore point (w)
		echo Exit Microsoft Edge Uninstaller (e)
		echo.

		set /P M=Type the letter next to your option then press ENTER:
		if %M%==q goto startmseb
		if %M%==w goto startmse
		if %M%==e (
			cls
			echo Leaving...
			exit /b
:startmseb
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
:startmse
	echo Checking if launched with administrative permissions (Needed to create system restore point)
	net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Administrative Permissions detected, continuing.
        goto startmse2
    ) else (
        echo Error: No administrative permissions. Please relaunch with Adnimistrative Permissions to remove Microsoft Edge.
        pause
        exit /b
    )
:startmse2
echo Killing Microsoft Edge...
taskkill /F /IM msedge.exe
cd /d "%ProgramFiles(x86)%\Microsoft"
for /f "tokens=1 delims=\" %%i in ('dir /B /A:D "%ProgramFiles(x86)%\Microsoft\Edge\Application" ^| find "."') do (set "edge_chromium_package_version=%%i")
if defined edge_chromium_package_version (
		echo Removing %edge_chromium_package_version%...
		Edge\Application\%edge_chromium_package_version%\Installer\setup.exe --uninstall --force-uninstall --msedge --system-level --verbose-logging
		EdgeCore\%edge_chromium_package_version%\Installer\setup.exe --uninstall --force-uninstall --msedge --system-level --verbose-logging
		powershell.exe -Command "Get-AppxPackage *MicrosoftEdge* | Remove-AppxPackage"
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
		powershell.exe -Command "Get-AppxPackage *edge* | Remove-AppxPackage"
	) else (
		echo Microsoft Edge [Legacy/UWP] not found, skipping.
	)

for /f "tokens=8 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" ^| findstr "Microsoft-Windows-MicrosoftEdgeDevToolsClient-Package" ^| findstr "~~"') do (set "melody_package_name=%%i")
if defined melody_package_name (
		echo Removing %melody_package_name%...
		reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%melody_package_name%" /v Visibility /t REG_DWORD /d 1 /f
		reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%melody_package_name%\Owners" /va /f
		dism /online /Remove-Package /PackageName:%melody_package_name% /NoRestart
	) else (
		echo Package not found.
	)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1
cls
echo Script has finished. If you have Microsoft Edge Legacy/UWP, you must reboot to take effect. Press any key to exit
pause >nul
exit /b
