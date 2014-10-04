;; Enter+<key> to Ctrl+<key>
Enter & a::Send ^a
Enter & b::Send ^b
Enter & c::Send ^c
Enter & d::Send ^d
Enter & e::Send ^e
Enter & f::Send ^f
Enter & g::Send ^g
Enter & h::Send ^h
Enter & i::Send ^i
Enter & j::Send ^j
Enter & k::Send ^k
Enter & l::Send ^l
Enter & m::Send ^m
Enter & n::Send ^n
Enter & o::Send ^o
Enter & p::Send ^p
Enter & q::Send ^q
Enter & r::Send ^r
Enter & s::Send ^s
Enter & t::Send ^t
Enter & u::Send ^u
Enter & v::Send ^v
Enter & w::Send ^w
Enter & x::Send ^x
Enter & y::Send ^y
Enter & z::Send ^z
Enter::Send {Enter}

;; Tab-h/l switch between windows
Tab & h::ShiftAltTab
Tab & l::AltTab
Tab::Send {Tab}

;; Win+Numpad{Sub,Add} change sound volume
#NumpadAdd::Send {Volume_Up 5}
#NumpadSub::Send {Volume_Down 5}
