#Requires AutoHotkey v2.0

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
Capslock::Control

!a::#^Left
!o::#^Right

#Include utils/programmer.ahk
#Include utils/dvorak.ahk

; win switcher

#Include utils/navigateUtils.ahk

!SC01E::GoToDesktopNumber(0) ; Alt + A
!SC01F::GoToDesktopNumber(1) ; Alt + S
!SC020::GoToDesktopNumber(2) ; Alt + D

^!SC01E::MoveCurrentWindowToDesktop(0) ; Ctrl + Alt + A
^!SC01F::MoveCurrentWindowToDesktop(1) ; Ctrl + Alt + S
^!SC020::MoveCurrentWindowToDesktop(2) ; Ctrl + Alt + D