GetWindowsVersion() {
    size := 284
    vi := Buffer(size, 0)
    NumPut("UInt", size, vi, 0)

    if DllCall("ntdll\RtlGetVersion", "Ptr", vi) != 0 {
        throw Error("No se pudo obtener la versión de Windows")
    }

    major := NumGet(vi, 4, "UInt")
    minor := NumGet(vi, 8, "UInt")
    build := NumGet(vi, 12, "UInt")

    return { major: major, minor: minor, build: build }
}

IsWindows11() {
    version := GetWindowsVersion()
    return version.major = 10 && version.build >= 22000
}