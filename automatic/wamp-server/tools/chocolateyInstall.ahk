wintitle = Setup - WampServer 2

WinWait, %wintitle%, 

IfWinNotActive, %wintitle%, , WinActivate, %wintitle%, 
WinWaitActive, %wintitle%, 
ControlSend,,{ALTDOWN}n{ALTUP}{ALTDOWN}a{ALTUP}{ALTDOWN}n{ALTUP}{ALTDOWN}n{ALTUP}{ALTDOWN}q{ALTUP}{ALTDOWN}d{ALTUP}{ALTDOWN}n{ALTUP}{ALTDOWN}i{ALTUP},%wintitle%
Sleep,50000
ControlSend,,{ALTDOWN}Y{ALTUP}{ALTDOWN}f{ALTUP},%wintitle%
