## Edge Remover
![Logo](https://i.imgur.com/SRMpQhj.png)  
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Microsoft Edge Remover is helping you to remove Microsoft Edge Legacy and Chromium in Windows.

## System Requirements

 - Windows 10 (all versions) and Windows 11

## Using the script

Just right click the `edge-remover.bat` file and click "Open as Administrator". The file can be found in release section or in this repo.

There will be options such as to remove edge with or without restore point etc. Type the letter next to your option and press `Enter` on your keyboard. 

## NOTE:
If you get the following error:
``Remove-AppxPackage : Deployment failed with HRESULT: 0x80073CFA, Removal failed. Please contact your software vendor.
(Exception from HRESULT: 0x80073CFA)
error 0x80070032: AppX Deployment Remove operation on package
Microsoft.MicrosoftEdgeDevToolsClient_1000.22621.1.0_neutral_neutral_8wekyb3d8bbwe from:
C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe failed. This app is part of Windows and
cannot be uninstalled on a per-user basis. An administrator can attempt to remove the app from the computer using Turn
Windows Features on or off. However, it may not be possible to uninstall the app.
NOTE: For additional information, look for [ActivityId] 66f1ae87-e0a9-0005-eb62-f266a9e0d801 in the Event Log or use
the command line Get-AppPackageLog -ActivityID 66f1ae87-e0a9-0005-eb62-f266a9e0d801
At line:1 char:35
+ Get-AppxPackage *MicrosoftEdge* | Remove-AppxPackage
+                                   ~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : WriteError: (Microsoft.Micro...l_8wekyb3d8bbwe:String) [Remove-AppxPackage], IOException
    + FullyQualifiedErrorId : DeploymentError,Microsoft.Windows.Appx.PackageManager.Commands.RemoveAppxPackageCommand``
    
Try [these steps](https://answers.microsoft.com/en-us/windows/forum/all/cant-remove-w10-packages-error-0x80073cfa/c224a864-b604-42b8-a770-57049e0dc50a) mentioned on this Microsoft Issue
