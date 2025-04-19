; custom maps --------------------------------------------------------------------------
VKE2::Shift
!q:: Send("!{F4}")
SC010:: Send(":")
+SC010:: Send(";")
CapsLock::Control
#SC010::#Up
Esc::$
!Esc::Esc
-::Enter
\::-
Enter::\

!,::#^Left
!.::#^Right

; flechas --------------------------------------------------------------------------
!h::Left
!j::Down
!k::Up
!l::Right
!g::Home
!r::End

; common shortcuts qwerty --------------------------------------------------------------------------
^k::^v
^j::^c
^q::^x
^'::^z
#+o:: Send("#+s")
#k::#v 
^,::^w

; tildes dvorak ------------------------------------------------------------------------------------
!a:: SendText("á")
!e:: SendText("é")
!i:: SendText("í")
!o:: SendText("ó")
!u:: SendText("ú")
!n:: SendText("ñ")

!+a:: SendText("Á")
!+e:: SendText("É")
!+i:: SendText("Í")
!+o:: SendText("Ó")
!+u:: SendText("Ú")
!+n:: SendText("Ñ")

; capa para qwerty ----------------------------------------------------------------------
toggle := false

#o:: {
    global toggle
    toggle := !toggle
    TrayTip("Keyboard mode", toggle ? "Qwerty layout" : "Dvorak layout")
}

#+a:: {
    global toggle
    TrayTip("Keyboard mode", toggle ? "You are using qwerty layout" : "You are using dvorak layout")
}


#HotIf toggle

; minusculas
SC010:: Send("q")
o::s
,::w
.::e
p::r
y::t
f::y
g::u
c::i
r::o
l::p
o::s
e::d
u::f
i::g
d::h
h::j
t::k
n::l
s:: SendText("ñ")
'::z
j::c
k::v
x::b
w::,
v::.
z::-
b::n
q::x
!a:: SendText("á")
!.:: SendText("é")
!c:: SendText("í")
!r:: SendText("ó")
!g:: SendText("ú")

; mayusculas
+SC010:: Send("Q")
+o::S
+,::W
+.::E
+p::R
+y::T
+f::Y
+g::U
+c::I
+r::O
+l::P
+a::A
+o::S
+e::D
+u::F
+i::G
+d::H
+h::J
+t::K
+n::L
+s:: SendText("Ñ")
+'::Z
+j::C
+k::V
+x::B
+z::_
+b::N
+q::X
!+a:: SendText("Á")
!+.:: SendText("É")
!+c:: SendText("Í")
!+r:: SendText("Ó")
!+g:: SendText("Ú")

; numeros
&::1
[::2
{::3
}::4
(::5
SC007::6
*::7
)::8
+::9
]::0

; simbolos
+&::!
+[::"
+{::#
+}::$
+(::%
+SC007::&
+*::/
+)::(
++::)
+]::=
!::'
+!::?
SC010::<
+SC007::>
+w::Send(";")
+v:: Send(":")
-:: SendText("{")
+-::[
\::}
+\::]
#:: SendText("¿")
+#:: SendText("¡")
!SC010::@
@::+
+@::*
VKE2::<
+VKE2::>
/::LAlt
+/:: SendText("¨")

; quitar custom keyshortcuts
CapsLock::CapsLock
Enter::Enter
Esc::Esc

#HotIf