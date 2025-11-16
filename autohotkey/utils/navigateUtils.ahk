#Include winUtils.ahk
SetWorkingDir(A_ScriptDir)

global MoveWindowToDesktopNumberProc
global GoToDesktopNumberProc
global IsWindowOnDesktopProc
global Validator

SetBasics(dll) {
    global MoveWindowToDesktopNumberProc, GoToDesktopNumberProc
    MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", dll, "AStr", "MoveWindowToDesktopNumber", "Ptr")
    GoToDesktopNumberProc         := DllCall("GetProcAddress", "Ptr", dll, "AStr", "GoToDesktopNumber", "Ptr")
}

if (IsWindows11()) {
    if A_IsCompiled {
        if !FileExist(A_ScriptDir "\vda11.dll")
            FileInstall("vda11.dll", A_ScriptDir "\vda11.dll", 1)
    }
    VDA_PATH := A_ScriptDir . "\vda11.dll"
    hVda11 := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")
    SetBasics(hVda11)

    IsWindowOnDesktopProc := DllCall("GetProcAddress", "Ptr", hVda11, "AStr", "IsWindowOnDesktopNumber", "Ptr")
    Validator := (windowID, num) => DllCall(IsWindowOnDesktopProc, "UInt", windowID, "UInt", num)

} else {
    if A_IsCompiled {
        if !FileExist(A_ScriptDir "\vda10.dll")
            FileInstall("vda10.dll", A_ScriptDir "\vda10.dll", 1)
    }
    VDA_PATH := A_ScriptDir . "\vda10.dll"
    hVda10 := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")
    SetBasics(hVda10)

    ViewIsShownInSwitchersProc := DllCall("GetProcAddress", "Ptr", hVda10, "AStr", "ViewIsShownInSwitchers", "Ptr")
    Validator := (windowID, num) =>  DllCall(ViewIsShownInSwitchersProc, "UInt", windowID)
}

FocusWindow(num := 1) {
    winIDList := WinGetList()
    for windowID in winIDList {
        windowIsOnDesktop := Validator(windowID, num)
        if (windowIsOnDesktop == 1) {
            WinActivate("ahk_id " windowID)
            return
        }
    }
}

MoveCurrentWindowToDesktop(num) {
    activeHwnd := WinGetID("A")
    DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", num, "Int")
    DllCall(GoToDesktopNumberProc, "Int", num, "Int")
}

GoToDesktopNumber(num) {
    DllCall(GoToDesktopNumberProc, "Int", num)
    FocusWindow(num)
}