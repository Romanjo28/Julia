using HorizonSideRobots 
include("roblib.jl")


function perimetr!(r::Robot)
    vertically,horizontal=angle(r)
    for side in (Nord,Ost,Sud,West)
        while isborder(r,side)==false
            putmarkers!(r,side)
        end
    end
    moves!(r,Ost,horizontal)
    moves1!(r,Nord,vertically)
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end



perimetr!(r)
