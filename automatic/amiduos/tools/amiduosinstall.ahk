#NoEnv 
#NoTrayIcon
;sleep 120000
;Send {Enter}
;WinWait, ahk_class #32770
;WinActivate
;IfWinActive
  ;Send {Enter}
;Sleep, 100

Count := 0
SetTimer CheckText, 1000 ; Each second (1000ms)
Return
CheckText:
    Count ++
    If (Count <= 60)
    {
        IfWinExist , Done
        {
            SetTimer CheckText, Off
            GoSub TextFound
        }
    } Else {
            SetTimer CheckText, Off
            GoSub TextNotFound
    }
Return

TextFound:
Send {Enter}
Return

TextNotFound:
; Your code here in case of timeout
Return
