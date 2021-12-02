@echo off

CD %HOMEDRIVE%%HOMEPATH%\Desktop
echo %CD%

REM ************ Main process *****************

echo *** Removing Microsoft Edge ***
call :killdir C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe
call :killdir "C:\Program Files (x86)\Microsoft\Edge"
call :killdir "C:\Program Files (x86)\Microsoft\EdgeUpdate"
call :killdir "C:\Program Files\Microsoft\Edge"
call :killdir "C:\Program Files\Microsoft\EdgeUpdate"
echo *** Modifying registry ***
call :editreg
echo *** Removing shortcuts ***
call :delshortcut "C:\Users\Public\Desktop\Microsoft Edge.lnk"
call :delshortcut "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
call :delshortcut "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"
echo Finished!
pause
exit

REM ************ KillDir: Take ownership and remove a directory *****************

:killdir
echo|set /p=Removing dir %1
if exist %1 (
	takeown /a /r /d Y /f %1 > NUL
	icacls %1 /grant administrators:f /t > NUL
	rd /s /q %1 > NUL
	if exist %1 (
		echo ...Failed.
	) else (
		echo ...Deleted.
	)
) else (
	echo ...does not exist.
)
exit /B 0

REM ************ Edit registry to add do not update Edge key *****************

:editreg
echo|set /p=Editting registry
echo Windows Registry Editor Version 5.00 > RemoveEdge.reg
echo. >> RemoveEdge.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate] >> RemoveEdge.reg
echo "DoNotUpdateToEdgeWithChromium"=dword:00000001 >> RemoveEdge.reg
echo. >> RemoveEdge.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}] >> RemoveEdge.reg

regedit /s RemoveEdge.reg
del RemoveEdge.reg
echo ...done.
exit /B 0

REM ************ Delete a shortcut *****************

:delshortcut
echo|set /p=Removing shortcut %1
if exist %1 (
	del %1
	echo ...done.
) else (
	echo ...does not exist.
)
exit /B 0