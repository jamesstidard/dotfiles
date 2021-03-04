#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

LCtrl & Tab:: AltTab
!Tab:: Send ^{Tab}
!+Tab:: Send ^+{Tab}

<^Space:: Send ^{Esc}

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


; === Backspace as Delete ===

>^Backspace::
    Send {Delete}
Return


; === Currency ===

<#3::
    Send £
Return

<#4::
    Send €
Return


; === Grave & Tilde on Escape ===

>^Esc::
    Send {`` down}
    Send {`` up}
Return

+Esc::
    Send {~ down}
    Send {~ up}
Return


; === HJKL Arrow Keys ===

>^J::
    Send {Down}
Return

>^K::
    Send {Up}
Return

>^H::
    Send {Left}
Return

>^L::
    Send {Right}
Return


; === F-Keys on Number Row ===

>^1::
    Send {F1}
Return

>^2::
    Send {F2}
Return

>^3::
    Send {F3}
Return

>^4::
    Send {F4}
Return

>^5::
    Send {F5}
Return

>^6::
    Send {F6}
Return

>^7::
    Send {F7}
Return

>^8::
    Send {F8}
Return

>^9::
    Send {F9}
Return

>^0::
    Send {F10}
Return

>^-::
    Send {F11}
Return

>^=::
    Send {F12}
Return


; === Media Keys on Number Row ===

>^<+7::
    Send {Media_Prev}
Return

>^<+8::
    Send {Media_Play_Pause}
Return

>^<+9::
    Send {Media_Next}
Return

>^<+0::
    Send {Volume_Mute}
Return

>^<+-::
    Send {Volume_Down}
Return

>^<+=::
    Send {Volume_Up}
Return

<+<^4::
    Send {PrintScreen}
Return


; === Window Snapping ===

<!<#<^H::
    Send #{Left Down}
Return

<!<#<^J::
    Send #{Down Down}
Return

<!<#<^K::
    Send #{Up Down}
Return

<!<#<^L::
    Send #{Right Down}
Return


; === Display Switching ===

<!<#<^1::
    Run python C:\Users\James\Development\James-Stidard\dotfiles\configs\display\switch muttson
Return

<!<#<^2::
    Run python C:\Users\James\Development\James-Stidard\dotfiles\configs\display\switch nigel
Return

<!<#<^3::
    Run python C:\Users\James\Development\James-Stidard\dotfiles\configs\display\switch freebie
Return
