using HorizonSideRobots
include("roblib.jl")

function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2, 4))
end

function tuda(r)
    for i in 1:12
        obhod(r, Ost)
        putmarker!(r)
    end 
    try_move!(r, Nord)
    putmarker!(r)
end 

function suda(r)
    for i in 1:12
        obhod(r, West)
        putmarker!(r)
    end 
    try_move!(r, Nord)
    putmarker!(r)
end 

function mark_all_2(r::Robot, side::HorizonSide)
    while isborder(r, Nord)==false && isborder(r, Ost)==false
        tuda(r, side)
        suda(r, inverse(side))
    end
end

mark_all_2(r, Ost)
