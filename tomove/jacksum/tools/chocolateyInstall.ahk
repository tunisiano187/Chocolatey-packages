#SingleInstance Force  ; Limit to only one run

SetTitleMatchMode(2)  ; accept incomplete title

WinWait("Jacksum")  ; wait for a window with "Jacksum" in the title to open
WinWaitActive("Jacksum")  ; wait for the window to be active

ControlClick("OK", "Jacksum")  ; Clic on OK

WinWaitClose("Jacksum")  ; Wait for window to close

ExitApp  ; end the script