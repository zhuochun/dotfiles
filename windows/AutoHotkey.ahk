;; """"""""""""""""""""""""""""""""""""""""""""""""""""""""
;; AutoHotkey Configurations
;; Author: Wang Zhuochun
;; Last Edit: 20/Jan/2015 05:29 PM
;; """"""""""""""""""""""""""""""""""""""""""""""""""""""""

#NoEnv
#SingleInstance force

SendMode Input ;; Recommended for new scripts due to its superior speed and reliability
SetTitleMatchMode RegEx ;; Change WinTitle match

;; Tab+<h/l> switch between windows {{{
Tab & h::ShiftAltTab
Tab & l::AltTab
Tab & b::Send {Left}
Tab & f::Send {Right}
Tab & j::Send {Down}
Tab & k::Send {Up}
Tab & ,::Send ^{Backspace}
Tab & .::Send ^+{Delete}
; Bring back Ctrl/Alt/Shift+Tab
^Tab::Send ^{Tab}
!Tab::Send !{Tab}
+Tab::Send +{Tab}
; Should work as usual
Tab::Send {Tab}
;; }}}

;; CapsLock to Ctrl {{{
;https://github.com/randyrants/sharpkeys
;SetCapsLockState, AlwaysOff
;CapsLock::Ctrl
;; }}}

;; Ctrl+Space to Ctrl+Shift {{{
^Space::Send ^{Shift}
;; }}}

;; Enter+<key> to Ctrl+<key> {{{
Enter & 1::Send ^1
Enter & 2::Send ^2
Enter & 3::Send ^3
Enter & 4::Send ^4
Enter & 5::Send ^5
Enter & 6::Send ^6
Enter & 7::Send ^7
Enter & 8::Send ^8
Enter & 9::Send ^9
Enter & 0::Send ^0
Enter & -::Send ^-
Enter & =::Send ^=
Enter & b::Send ^b
Enter & c::Send ^c
Enter & d::Send ^d
Enter & f::Send ^f
Enter & g::Send ^g
Enter & i::Send ^i
Enter & m::Send ^m
Enter & n::Send ^n
Enter & o::Send ^o
Enter & p::Send ^p
Enter & q::Send ^q
Enter & r::Send ^r
Enter & s::Send ^s
Enter & t::Send ^t
Enter & u::Send ^u
Enter & v::Send ^v
Enter & w::Send ^w
Enter & x::Send ^x
Enter & y::Send ^y
Enter & z::Send ^z
; I do mean Home and End
Enter & a::Send {Home}
Enter & e::Send {End}
; The special ones
Enter & h::Send ^#h
Enter & j::Send ^#j
Enter & k::Send ^#k
Enter & l::Send ^#l
; Bring back Ctrl/Shift+Enter
^Enter::Send ^{Enter}
+Enter::Send +{Enter}
; Should work as usual
Enter::Send {Enter}
;; }}}

;; Win+Numpad{Sub,Add} change sound volume {{{
#NumpadAdd::Send {Volume_Up 5}
#NumpadSub::Send {Volume_Down 5}
;; }}}

;; Win+` toggle always on top {{{
#`::
    WinSet, AlwaysOnTop, Toggle, A
return
;; }}}

;; Win+j move the active window between monitors
#j::
    ; get the active window's id
    WinGet, winID, ID, A
    ; get the active window's position (x, y)
    WinGetPos, winX, winY, , , A

    if (winX >= 1900)
      WinMove, ahk_id %winID%, , (winX-1920), winY
    else
      WinMove, ahk_id %winID%, , (winX+1920), winY
return

;; Win+Shift+L measure selected text length {{{
#+L::
    ; reset and copy selected text to clipboard
    Clipboard =
    SendInput ^c
    ClipWait
    ; get length of text
    text := clipboard
    StringLen, textLength, text
    ; save length to clipboard
    Clipboard := textLength
    ; report length
    MsgBox, "%text%" has %textLength% characters.
Return
;; }}}

;; Elementary window switch {{{

;; 1. Move mouse to corners on screen
;; 2. Focus on the window under cursor
;; 3. Center mouse respect to the window

;; Ctrl+Win+h Left {{{
^#h::
    ; set mouse movements relative to screen
    CoordMode, Mouse, Screen
    ; move to corner on screen
    MouseGetPos, xPos, yPos
    MouseMove 90, %yPos%, 0
    ; activate window under cursor
    MouseGetPos, , , winID
    WinActivate, ahk_id %winID%
    ; move to center of window
    WinGetPos , , , winWidth, winHeight, A
    MouseMove, (winWidth/2), (winHeight/2), 0
return
;; }}}

;; Ctrl+Win+j Down {{{
^#j::
    CoordMode, Mouse, Screen
    MouseGetPos, xPos, yPos
    yWin := A_ScreenHeight - 90
    MouseMove %xPos%, %yWin%, 0
    MouseGetPos, , , winID
    WinActivate, ahk_id %winID%
    WinGetPos , , , winWidth, winHeight, A
    MouseMove, (winWidth/2), (winHeight/2), 0
return
;; }}}

;; Ctrl+Win+k Up {{{
^#k::
    CoordMode, Mouse, Screen
    MouseGetPos, xPos, yPos
    MouseMove %xPos%, 90, 0
    MouseGetPos, , , winID
    WinActivate, ahk_id %winID%
    WinGetPos , , , winWidth, winHeight, A
    MouseMove, (winWidth/2), (winHeight/2), 0
return
;; }}}

;; Ctrl+Win+l Right {{{
^#l::
    CoordMode, Mouse, Screen
    MouseGetPos, xPos, yPos
    xWin := A_ScreenWidth - 90
    MouseMove %xWin%, %yPos%, 0
    MouseGetPos, , , winID
    WinActivate, ahk_id %winID%
    WinGetPos , , , winWidth, winHeight, A
    MouseMove, (winWidth/2), (winHeight/2), 0
return
;; }}}
;; }}}

;; CmdPrompt Shortcuts {{{
; https://github.com/denolfe/AutoHotkey/tree/master/AppSpecific
#IfWinActive ahk_class ConsoleWindowClass
    ; Paste
    ^V::SendInput {Raw}%clipboard%

    ; Ctrl+L for clear
    ^L::SendInput, {Esc}cls{Enter}
#IfWinActive
;; }}}

;; vim:fdm=marker
