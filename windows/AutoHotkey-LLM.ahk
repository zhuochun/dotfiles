﻿#Requires AutoHotkey v2.0

#SingleInstance Force

; Hotkey definitions
#!i:: ProcessText("EN")     ; Win+Alt+I to Translate into English
#!o:: ProcessText("WRITE")  ; Win+Alt+O to Correct English

ProcessText(promptOption) {
    ; Backup clipboard
    originalClip := ClipboardAll()
    A_Clipboard := ""

    ; Get active input text
    Send "^a"
    Send "^c"
    if !ClipWait(2) {
        MsgBox "Failed to get text from input field"
        return
    }

    inputText := A_Clipboard

    ; Create temp file with UTF-8 encoding
    tempFile := A_Temp "\temp_input.txt"
    try {
        FileEncoding "UTF-8"
        if FileExist(tempFile) {
            FileDelete tempFile
        }
        FileAppend inputText, tempFile
    } catch Error as err {
        MsgBox "Error writing temp file: " err.Message
        return
    }

    ; ; Execute Ruby script
    try {
        rubyCmd := 'ruby D:\GitHub\dotfiles\bin\ai-chat "' tempFile '" -i --prompt=' promptOption
        result := RunWait(rubyCmd, , "Hide", &exitCode)
        if exitCode = 1 {
            MsgBox "Ruby script failed with exit code: " exitCode
            return
        }
    } catch Error as err {
        MsgBox "Error executing Ruby script: " err.Message
        return
    }

    ; Read processed text
    try {
        FileEncoding "UTF-8"
        processedText := FileRead(tempFile)

        ; Insert processed text
        A_Clipboard := processedText
        Send "^a"
        Send "^v"
    } catch Error as err {
        MsgBox "Error reading processed file: " err.Message
        return
    }
}