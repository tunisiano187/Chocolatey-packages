#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, Drobo Dashboard - InstallShield Wizard, Select the language for the installation from the choices below. , 90
WinActivate
Send !o
WinWaitActive, Drobo Dashboard - InstallShield Wizard , Welcome to the InstallShield Wizard , 90
WinActivate
Send !n
Send !n
Send !a
Send !n
Send !n
Send !n
Send !i
WinWaitActive, Drobo Dashboard - InstallShield Wizard, InstallShield Wizard Completed, 90
WinActivate
Send {Tab}
Send {Space}
Send !f
