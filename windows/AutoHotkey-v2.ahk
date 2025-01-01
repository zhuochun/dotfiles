;; """"""""""""""""""""""""""""""""""""""""""""""""""""""""
;; AutoHotkey Configurations (AutoHotkey v2)
;; Author: Wang Zhuochun
;;
;; To add this script at startup: https://www.howtogeek.com/208224/how-to-add-a-program-to-startup-in-windows/
;;
;; Open the Startup Folder:
;;
;; - Press Windows Key + R to open the Run dialog box.
;; - Type shell:startup and press Enter.
;;
;; Create a Shortcut:
;;
;; - In the Startup folder, right-click on an empty space and select New > Shortcut.
;; - Click Browse and navigate to the executable file (.exe) of the program you wish to add.
;; - Select the file, click OK, then Next.
;; - Provide a name for the shortcut and click Finish.
;; """"""""""""""""""""""""""""""""""""""""""""""""""""""""

#Requires AutoHotkey v2.0

#SingleInstance Force

; -- Tab + h/l to switch between windows --
Tab & h::ShiftAltTab ; Alt+Shift+Tab
Tab & l::AltTab ; Alt+Tab

; Bring back Ctrl/Alt/Shift + Tab
^Tab::Send("^{Tab}")
!Tab::Send("!{Tab}")
+Tab::Send("+{Tab}")

; Normal Tab
Tab::Send("{Tab}")

; -- Text Expansion with ';' prefix --
::;tm::
{
    Send(A_Hour ":" A_Min)
    return
}

::;now::
{
    Send(A_Hour ":" A_Min)
    return
}

::;dt::
{
    Send(A_YYYY "-" A_MM "-" A_DD)
    return
}

; -- Use ai-chat cmd with Expansion
::;en::
{
    ProcessText("EN")
    return
}

::;cn::
{
    ProcessText("CN")
    return
}

::;ai::
{
    ProcessText("")
    return
}

ProcessText(promptOption) {
    ; Read clipboard
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
        if (promptOption != "") {
            rubyCmd := 'ruby D:\GitHub\dotfiles\bin\ai-chat "' tempFile '" -i --model=ollama:qwen2.5:3b --prompt="' promptOption '"'
        } else {
            rubyCmd := 'ruby D:\GitHub\dotfiles\bin\ai-chat "' tempFile '" -i --model=ollama:qwen2.5:3b'
        }

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