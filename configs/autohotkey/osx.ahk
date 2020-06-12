#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

LCtrl & Tab:: AltTab
!Tab:: Send ^{Tab}
!+Tab:: Send ^+{Tab}

^Space:: Send ^{Esc}

^Left::
    Send {Home}
Return

^Right::
    Send {End}
Return

^+Left::
    Send +{Home}
Return

^+Right::
    Send +{End}
Return

^Up::
    Send ^{Home}
Return

^Down::
    Send ^{End}
Return

^+Up::
    Send ^+{Home}
Return

^+Down::
    Send ^+{End}
Return

>+J::
    Send {Down}
Return

>+K::
    Send {Up}
Return

>+H::
    Send {Left}
Return

>+L::
    Send {Right}
Return
