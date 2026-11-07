; environment
#NoEnv
#NoTrayIcon
SendMode Input
DetectHiddenText, off  ;toggle search hidden window text
DetectHiddenWindows, off  ;toggle detect hidden windows
SetTitleMatchMode, 2   ;contains

winTitle = Windows Security ahk_class #32770

; Drivers install - wait up to 60 seconds for each dialog, exit cleanly if it doesn't appear
WinWait, %winTitle%, , 60
if ErrorLevel
    ExitApp
WinActivate
ControlClick, &Install, %winTitle%
Sleep, 100
WinWait, %winTitle%, , 60
if ErrorLevel
    ExitApp
WinActivate
ControlClick, &Install, %winTitle%
Sleep, 100
WinWait, %winTitle%, , 60
if ErrorLevel
    ExitApp
WinActivate
ControlClick, &Install, %winTitle%
Sleep, 100

ExitApp