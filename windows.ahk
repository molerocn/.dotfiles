#Requires AutoHotkey v2.0

CapsLock::Control
SetTimer(CheckCapsLock, 100)
CheckCapsLock() {
    ; Si CapsLock está encendido (T = Toggle state), lo apaga
    if GetKeyState("CapsLock", "T") {
        SetCapsLockState("AlwaysOff")
    }
}

VKE2::Shift ; close shift
!Enter::\
SC02B::Enter ; close enter
^SC1B::return
!+SC02C::Send("!{F4}") ; cerrar ventana
^#SC010::Send("{F11}") ; maximizar ventana
#SC010::#Up ; expandir ventana
z::Shift ; swipe z
RShift::z ; swipe z
^+Esc::^+Esc
!SC024::Up
!SC032::Down
+Backspace::Backspace
; ^!t::^k ; ctrl alt k
#+SC01F::#+s ; screenshot
^SC02E::^c ; copiar
^SC02F::^v ; pegar
#SC02F::#v ; clipboard history
^SC02D::^x ; cortar
^SC02C::^z ; deshacer
; ^SC011::^w ; cerrar la ventana
; ^!SC02E::^j
; ^!SC02F::^!k
; LControl::Escape
!Space::^Escape

!+a::SendText("á")
!+e::SendText("é")
!+i::SendText("í")
!+o::SendText("ó")
!+u::SendText("ú")

SC29::$
SC02::&
SC03::SendText("{")
SC04::(
SC05::)
SC06::[
SC07::+
SC08::*
SC09::]
SC0A::=
SC0B::}
SC0C::!
SC0D::#
SC1B::@

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
+SC1B::^

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
!SC010::!'

^SC002::^1
^SC003::^2
^SC004::^3
^SC005::^4
^SC006::^5
^SC007::^+
^SC008::^7
^SC009::^8
^SC00A::^9
^SC00B::^0

VDA_PATH := EnvGet("USERPROFILE") . "\VirtualDesktopAccessor.dll"
vda := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

pGoToDesktop := DllCall("GetProcAddress", "Ptr", vda, "AStr", "GoToDesktopNumber", "Ptr")
pMoveWindowToDesktop := DllCall("GetProcAddress", "Ptr", vda, "AStr", "MoveWindowToDesktopNumber", "Ptr")
; pIsWindowOnDesktop := DllCall("GetProcAddress", "Ptr", vda, "AStr", "ViewIsShownInSwitchers", "Ptr") ; W10
pIsWindowOnDesktop := DllCall("GetProcAddress", "Ptr", vda, "AStr", "IsWindowOnDesktopNumber", "Ptr") ; W11

GoToDesktop         := (desktopNumber) => DllCall(pGoToDesktop, "Int", desktopNumber, "Int")
MoveWindowToDesktop := (windowID, desktopNumber) => DllCall(pMoveWindowToDesktop, "Ptr", windowID, "Int", desktopNumber, "Int")
IsWindowOnDesktop   := (windowID, desktopNumber) => DllCall(pIsWindowOnDesktop, "Ptr", windowID, "Int", desktopNumber, "Int")

; FocusRecentWindowOnDesktop(desktopNumber := 0) {
;     winIDList := WinGetList()
;     for windowID in winIDList {
;         if (WinGetStyle(windowID) & 0x10000000) && (IsWindowOnDesktop(windowID, desktopNumber) == 1) {
;             WinActivate("ahk_id " windowID)
;             return
;         }
;     }
; }

FocusRecentWindowOnDesktop(desktopNumber := 0) {
    for hwnd in WinGetList() {
        if (WinGetStyle(hwnd) & 0x10000000)
        && (IsWindowOnDesktop(hwnd, desktopNumber) == 1) {
            WinActivate(hwnd)
            return
        }
    }
}

MoveCurrentWindowToDesktop(desktopNumber) {
    MoveWindowToDesktop(WinGetID("A"), desktopNumber)
    GoToDesktop(desktopNumber)
}

GoToDesktopNumber(desktopNumber) {
    GoToDesktop(desktopNumber)
    FocusRecentWindowOnDesktop(desktopNumber)
}

!SC01E::GoToDesktopNumber(0) ; Alt + A
!SC01F::GoToDesktopNumber(1) ; Alt + S
!SC020::GoToDesktopNumber(2) ; Alt + D
!SC010::GoToDesktopNumber(3) ; Alt + Q
!SC011::GoToDesktopNumber(4) ; Alt + W
!SC012::GoToDesktopNumber(5) ; Alt + E
!SC002::GoToDesktopNumber(6) ; Alt + 1
!SC003::GoToDesktopNumber(7) ; Alt + 2
!SC02D::GoToDesktopNumber(8) ; Alt + X

^!SC01E::MoveCurrentWindowToDesktop(0) ; Ctrl + Alt + A
^!SC01F::MoveCurrentWindowToDesktop(1) ; Ctrl + Alt + S
^!SC020::MoveCurrentWindowToDesktop(2) ; Ctrl + Alt + D
^!SC010::MoveCurrentWindowToDesktop(3) ; Ctrl + Alt + Q
^!SC011::MoveCurrentWindowToDesktop(4) ; Ctrl + Alt + W
^!SC012::MoveCurrentWindowToDesktop(5) ; Ctrl + Alt + E
^!SC002::MoveCurrentWindowToDesktop(6) ; Ctrl + Alt + 1
^!SC003::MoveCurrentWindowToDesktop(7) ; Ctrl + Alt + 2
^!SC02D::MoveCurrentWindowToDesktop(8) ; Ctrl + Alt + X
