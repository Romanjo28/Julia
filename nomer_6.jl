include("roblib.jl")

function find_border!(r::Robot, mov::HorizonSide, bord::HorizonSide)
    while isborder(r, bord) == false
        if isborder(r, mov) == false
            move!(r, mov)
        else
            move!(r, bord)
            mov = inverse(mov)
        end
    end
    return mov
end


function fin!(r::Robot)
    num_y1 = moves!(r, Sud)
    num_x = moves!(r, West)
    num_y2 = moves!(r, Sud)
    side = find_border!(r, Nord, Ost)
    mark_perimetr!(r, side)
    moves!(r, West)
    moves!(r, Sud)
end

fin!(r)

