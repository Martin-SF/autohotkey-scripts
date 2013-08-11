/*
 * Microphone Status
 *
 * Shows the current status of the microphone (or really any device)
 *
 * Requirements:
 *     - AutoHotkey v1.1.+ (maybe)
 */

VERSION := "0.0.1"

; BUG: if some fatal error happens and app closes it doesn't close the whole
; application. Thus needs this to say only have one running.
#SingleInstance force
#NoEnv

; TODO: move to config file / create a config screen
;device_id := 8
;component_type := "Master"
IniRead, device_id, config.ini, sound_device, device_id
IniRead, component_type, config.ini, sound_device, component_type
IniRead, always_on_top, config.ini, app, always_on_top, True

; shouldn't have to change these
refresh_rate := 2000  ; in msec, 500 is probably as low as you should go
muted_img := "img_muted.png"
unmuted_img := "img_unmuted.png"

; Error Checking
if (FileExist(muted_img) = "") {
    MsgBox, Muted image file %muted_img% does not exist
    ExitApp
}
if (FileExist(unmuted_img) = "") {
    MsgBox, Unmuted image file %unmuted_img% does not exist
    ExitApp
}

gosub GetMicrophoneStatus

gui_options := ""
if always_on_top = True
    gui_options := "+AlwaysOnTop"

Gui %gui_options%
Gui Add, Picture, vMicStatus gToggleMic, %microphone_status%
Gui Show,, Microphone Status

SetTimer, UpdateMicrophoneStatus, %refresh_rate%

return


; Toggles the microphone status
ToggleMic:
    if (A_GuiEvent = "DoubleClick")
        SoundSet, +1, %component_type%, Mute, %device_id%
        gosub UpdateMicrophoneStatus
return

; sets the microphone_status variable
GetMicrophoneStatus:
    SoundGet, microphone_state, %component_type%, Mute, %device_id%
    if ErrorLevel {
        MsgBox, Could not get microphone state: %ErrorLevel%
        ExitApp
    }

    ; On = Mute is confusing
    if microphone_state = On
        microphone_status = %muted_img%
    else
        microphone_status = %unmuted_img%
return

; updates the status of microphone if it changed
UpdateMicrophoneStatus:
    prev_status = %microphone_status%
    ;MsgBox, Previous status: %prev_status%
    gosub GetMicrophoneStatus
    if (prev_status != microphone_status)
        GuiControl,, MicStatus, %microphone_status%
return

GuiEscape:
GuiClose:
ExitApp
