;; """"""""""""""""""""""""""""""""""""""""""""""""""""""""
;; AutoHotkey Configurations (ErgoDox)
;; Author: Wang Zhuochun
;; """"""""""""""""""""""""""""""""""""""""""""""""""""""""

#NoEnv
#SingleInstance force

SendMode Input ;; Recommended for new scripts due to its superior speed and reliability
SetTitleMatchMode RegEx ;; Change WinTitle match

;; Tab+<h/l> switch between windows {{{
Tab & h::ShiftAltTab
Tab & l::AltTab
; Bring back Ctrl/Alt/Shift+Tab
^Tab::Send ^{Tab}
!Tab::Send !{Tab}
+Tab::Send +{Tab}
; Should work as usual
Tab::Send {Tab}
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

;; Text Expansion with <;> {{{
::;tm::
SendInput %A_Hour%:%A_Min%
return

::;now::
SendInput %A_Hour%:%A_Min%
return

::;dt::
SendInput %A_YYYY%-%A_MM%-%A_DD%
return
;; }}}

;; 中文直角引号 Alt+Shift {{{
!+[::send,{U+300C}            ;// alt + shift + [  转换为「
!+]::send,{U+300D}            ;// alt + shift + ]  转换为 」
;; }}}

;; OpenAI Complete (Experimental) {{{
^+i::
{
    ; Prompt the user for a message
    InputBox, message, Enter Prompt, Write the Message:

    ; Execute a PowerShell command using the message and selected text as input
    RunWait, powershell.exe -ExecutionPolicy Bypass -Command "& {ruby 'D:\GitHub\dotfiles\bin\ai-chat' '%message%' > output.txt}", , Hide

    ; Read the output of the command from the temporary file
    FileRead, output, output.txt
    ; Copy the output to the clipboard
    Clipboard := output

    ; Info completion
    MsgBox, , Chat, %output%,
}
return
;;}}}


;; vim:fdm=marker
