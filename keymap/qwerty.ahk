CapsLock::Control
VKE2::Shift
SC028::Enter
}::SendText("-")
+}::SendText("_")
Enter::\
+Enter::SendText("|")

!w::#^Left
!e::#^Right

; minusculas
SC010:: Send(":")
s::o
w::,
e::.
r::p
t::y
y::f
u::g
i::c
o::r
p::l
s::o
d::e
f::u
g::i
h::d
j::h
k::t
l::n
ñ::s
z::'
c::j
v::k
b::x
,::w
.::v
-::z
n::b
x::q

; mayusculas
+SC010:: Send(";")
+s::O
+w::<
+e::>
+r::P
+t::Y
+y::F
+u::G
+i::C
+o::R
+p::L
+s::O
+d::E
+f::U
+g::I
+h::D
+j::H
+k::T
+l::N
+ñ::S
+z::"
+c::J
+v::K
+b::X
+,::W
+.::V
+-::Z
+n::B
+x::Q

; numeros
1::&
2::[
3::SendText("{")
4::SendText("}")
5::(
6:: Send("=")
7::*
8::)
9::+
0::]
'::!

; numeros
+1::%
+2::7
+3::5
+4::SendText("3")
+5::1
+6::9
+7::0
+8::2
+9::SendText("4")
+0::SendText("6")
+'::8
¿::#
+¿::`
|::SendText("$")
+|::~

+::@
++::SendText("^")
SC01A::/
+SC01A::?

; common shortcuts
^v::^v
^c::^c
^x::^x
^z::^z
#+s:: Send("#+s")
#v::#v 
^w::^w