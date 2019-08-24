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

;; vim:fdm=marker
