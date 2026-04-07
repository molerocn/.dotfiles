#Requires AutoHotkey v2.0

; ----------------------------------------- capslock

; CapsLock::Escape
CapsLock::Control
SetTimer(CheckCapsLock, 100)
CheckCapsLock() {
    ; Si CapsLock está encendido (T = Toggle state), lo apaga
    if GetKeyState("CapsLock", "T") {
        SetCapsLockState("AlwaysOff")
    }
}

; ----------------------------------------- capslock

; ----------------------------------------- keymaps

;; LControl::Esc
+SC1B::Backspace
VKE2::Shift
!Enter::\
SC02B::Enter
SC02C:::
+SC02C::;
!+SC02C::Send("!{F4}")
^#SC010::Send("{F11}")
#SC010::#Up
z::Shift
RShift::z
!Backspace::@
!+Backspace::^
SC1B::Backspace
^+Esc::^+Esc
!g::Media_Prev
!l::Media_Next
^!t::^k

XButton1::#^Left
XButton2::#^Right

!SC002::!1
!SC003::!2
!SC004::!3
!SC005::!4
!SC006::!5
!SC007::!6
!SC008::!7
!SC009::!8
!SC00A::!9
!SC00B::!0

^SC002::^1
^SC003::^2
^SC004::^3
^SC005::^4
^SC006::^5
^SC007::^6
^SC008::^7
^SC009::^8
^SC00A::^9
^SC00B::^0

!SC024::Up
!SC032::Down

SC29::$
SC02::&
SC03::[
SC04::SendText("{")
SC05::}
SC06::(
SC07::*
SC08::+
SC09::)
SC0A::=
SC0B::]
SC0C::!
SC0D::#

+SC29::~
+SC02::%
+SC03::7
+SC04::5
+SC05::3
+SC06::1
+SC07::9
+SC08::0
+SC09::2
+SC0A::4
+SC0B::6
+SC0C::8
+SC0D::`

#+SC01F::#+s
;^SC011::^w

^SC02E::^c
^!SC02E::^j
^SC02F::^v
^!SC02F::^!k
#SC02F::#v
^SC02D::^x
^SC02C::^z

; ----------------------------------------- keymaps

; ----------------------------------------- Nav

global MoveWindowToDesktopNumberProc
global IsWindowOnDesktopProc
global GoToDesktopNumberProc

VDA_PATH := EnvGet("USERPROFILE") . "\.lib\VirtualDesktopAccessor.dll"
hVda11 := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVda11, "AStr", "MoveWindowToDesktopNumber", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVda11, "AStr", "GoToDesktopNumber", "Ptr")
IsWindowOnDesktopProc := DllCall("GetProcAddress", "Ptr", hVda11, "AStr", "IsWindowOnDesktopNumber", "Ptr")

FocusWindow(num := 1) {
    winIDList := WinGetList()
    for windowID in winIDList {
        windowIsOnDesktop := DllCall(IsWindowOnDesktopProc, "UInt", windowID, "UInt", num)
        if (windowIsOnDesktop == 1) {
            WinActivate("ahk_id " windowID)
            return
        }
    }
}

MoveCurrentWindowToDesktop(num) {
    activeHwnd := WinGetID("A")
    DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", num, "Int")
}

GoToDesktopNumber(num) {
    DllCall(GoToDesktopNumberProc, "Int", num)
    FocusWindow(num)
}

; ----------------------------------------- Nav

; ----------------------------------------- Nav maps

!SC01E::GoToDesktopNumber(0) ; Alt + A
!SC01F::GoToDesktopNumber(1) ; Alt + S
!SC020::GoToDesktopNumber(2) ; Alt + D
!SC002::GoToDesktopNumber(3) ; Alt + 1
!SC003::GoToDesktopNumber(4) ; Alt + 2
!SC02D::GoToDesktopNumber(5) ; Alt + X

^!SC01E::MoveCurrentWindowToDesktop(0) ; Ctrl + Alt + A
^!SC01F::MoveCurrentWindowToDesktop(1) ; Ctrl + Alt + S
^!SC020::MoveCurrentWindowToDesktop(2) ; Ctrl + Alt + D
^!SC002::MoveCurrentWindowToDesktop(3) ; Ctrl + Alt + 1
^!SC003::MoveCurrentWindowToDesktop(4) ; Ctrl + Alt + 2
^!SC02D::MoveCurrentWindowToDesktop(5) ; Ctrl + Alt + X

; ----------------------------------------- Nav maps
