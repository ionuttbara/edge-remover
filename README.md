## Edge Remover
![Logo](https://i.imgur.com/SRMpQhj.png)  
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

## Introduction
Microsoft Edge Remover is a tool designed to help Windows users remove Microsoft Edge Chromium and Edge UWP from their devices. The tool provides two versions for users to choose from: Terminal Version (v1.5) and GUI Version (v2.5). Both versions are easy to use and come with different options for removing Edge, including with or without creating a restore point. The GUI Version (v2.5) also includes argument support for more advanced users. By removing Microsoft Edge, users can free up space on their devices and eliminate any unwanted software.

## System Requirements

 - The Microsoft Edge Remover tool requires a Windows operating system to function. It is compatible with Windows 10 (all versions) and Windows 11. Before using the tool, it is important to ensure that the user's device meets the system requirements. This will ensure that the tool runs smoothly and effectively removes Microsoft Edge Chromium and Edge UWP. The tool may also require administrator permission to run, depending on the user's version of Windows. By having the correct system requirements, users can be confident that the Microsoft Edge Remover tool will work efficiently on their device.

## Using the script (Terminal Version, v1.5)

Just right click the `edge-remover.bat` file and click "Open as Administrator". The file can be found in release section or in this repo.

There will be options such as to remove edge with or without restore point etc. Type the letter next to your option and press `Enter` on your keyboard. 


## Using the script (GUI Version v2.5)
![image](https://user-images.githubusercontent.com/76656855/216146766-f081bb17-b73f-41f2-9b17-4d3a47e75181.png)

Download `` .exe  `` version of script and run. Depend of your version of Windows, Administrator Permission is needed to run to work properly.

You have some buttons which will do desired action.

You have 4 buttons , which is remove Edge Chormium, Edge UWP and Create System Restore Point.
Also, in version 2.5 is having Argument Support.
To remove Edge Chromium Browser using the app wrtie this console line.
```
EdgeRemover /ch
```

```
EdgeRemover /CH
```

To remove Edge UWP Browser using the app write this console line.
```
EdgeRemover /UWP
```

```
EdgeRemover /uwp
```

To remove Edge UWP and Edge Chromium (reboot needed) using the app write this in console line.

```
EdgeRemover /all
```

```
EdgeRemover /ALL
```


