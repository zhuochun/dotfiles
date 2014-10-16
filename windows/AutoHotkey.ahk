;; """"""""""""""""""""""""""""""""""""""""""""""""""""""""
;; AutoHotkey Configurations
;; Author: Wang Zhuochun
;; Last Edit: 15/Oct/2014 08:10 AM
;; """"""""""""""""""""""""""""""""""""""""""""""""""""""""

#NoEnv
#SingleInstance force

;; Capslock to Ctrl {{{
Capslock::Ctrl
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
; I mean Home, End
Enter & a::Send {Home}
Enter & e::Send {End}
; the special ones
Enter & h::Send ^#h
Enter & j::Send ^#j
Enter & k::Send ^#k
Enter & l::Send ^#l
Enter::Send {Enter}
;; }}}

;; Tab+<h/l> switch between windows {{{
Tab & h::ShiftAltTab
Tab & l::AltTab
Tab::Send {Tab}
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

;; Win+L measure selected text length {{{
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

;; Left {{{
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

;; Down {{{
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

;; Up {{{
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

;; Right {{{
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

;; vim:fdm=marker
