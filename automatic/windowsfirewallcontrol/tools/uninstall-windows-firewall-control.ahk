#SingleInstance ; Ensure only one instance at a time
#Persistent ; Ensure the script persists until an ExitApp
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Client ; All used coordinates are now relative to the upper left corner of the active Window and thus should work for everyone.

WinWaitActive, Malwarebytes Windows Firewall Control
Click, left, 46, 197 ; chooses the third selection box which preserves the stored firewall rules. This enables a quick reinstallation without the loss of most settings.
Sleep 4000 ; Waits for 4s to allow the user to choose another option.
Click, left, 433, 292 ; presses the next button to start the Deinstallation.
WinWaitActive, Malwarebytes Windows Firewall Control
;Waits until the Deinstallation is completed successfully.
While(WinExist("Malwarebytes Windows Firewall Control")){
	Sleep 200
}
ExitApp