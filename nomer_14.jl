include("roblib.jl")

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))
next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))

function mark_cross!(r::Robot)
    for side in (Nord,Ost,Sud,West)
        putmarkers!(r,side)
        if isborder(r,side)==true && isborder(r,next(side))==false
            obhod(r,side)
            putmarker!(r)
            putmarkers!(r,side)
        end
        side_inv=inverse(side)
        move_by_marker!(r,side_inv)
    end
putmarker!(r)
end

function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

function move_by_marker!(r::Robot,side::HorizonSide)
    while ismarker(r)==true
        if isborder(r,side)==false
            move!(r,side)
        elseif isborder(r,side)==true && isborder(r,next(side))==false
            obhod(r,side)
        end
    end
end

mark_cross!(r)
