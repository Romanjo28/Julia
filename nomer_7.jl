using HorizonSideRobots 
include("lib_for_practic_10.jl")

function cherez_2(r::Robot, side::HorizonSide)
    while !(isborder(r, side))
        putmarker!(r)
        try_move!(r, side)
        try_move!(r,side)
    end
end

function step_verh(r::Robot, side::HorizonSide)
    if ismarker(r)==false
        move!(r, Nord)
    end

    if ismarker(r)==true
        move!(r, Nord)
        move!(r, side)
    end
end

function mark_2(r::Robot) 
    while (isborder(r, Nord)==false && isborder(r, Ost)==false) 
        cherez_2(r, Ost)
        step_verh(r, West)
        cherez_2(r, West)
        step_verh(r, Ost)
    end
end

mark_2(r)
