using System;
using System.Diagnostics;

class EdgeUninstaller
{
    public static void Main(string[] args)
    {
        // Check if Edge is installed via winget
        var winget = new Process
        {
            StartInfo = new ProcessStartInfo
            {
                FileName = "winget",
                Arguments = "show Microsoft.Edge",
                RedirectStandardOutput = true,
                UseShellExecute = false,
                CreateNoWindow = true,
            }
        };
        winget.Start();
        string output = winget.StandardOutput.ReadToEnd();

        // If Edge is installed, run the commands to kill the Edge process and uninstall the Edge package
        if (output.Contains("Name: Microsoft.Edge"))
        {
            var taskkill = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = "taskkill",
                    Arguments = "/F /IM MicrosoftEdge.exe",
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                }
            };
            taskkill.Start();
            taskkill.WaitForExit();

            var wingetUninstall = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = "winget",
                    Arguments = "uninstall -h Microsoft.Edge",
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                }
            };
            wingetUninstall.Start();
            wingetUninstall.WaitForExit();
        }
    }
}
