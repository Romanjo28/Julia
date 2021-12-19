using HorizonSideRobots

function draw!(r::Robot, side1::HorizonSide, side2::HorizonSide)
    while (isborder(r, side1) || isborder(r, side2)) == false
        move!(r, side1)
        move!(r, side2)
        putmarker!(r)
    end
end

function back!(r::Robot, side1::HorizonSide, side2::HorizonSide)
    while ismarker(r)
        move!(r, side1)
        move!(r, side2)
    end
end


function diag!(r::Robot)
    vec = West
    for side in [Nord, Sud]
        draw!(r, vec, side)
        back!(r, inverse(vec), inverse(side))
    end

    vec = Ost
    for s in [Nord, Sud]
        draw!(r, vec, side)
        back!(r, inverse(vec), inverse(side))
    end

    putmarker!(r)
end

diag!(r)
