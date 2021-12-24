function all_corners_mark(r::Robot)
    coordinates = []
    cornerwalk(r, coordinates, West, Sud)
    go_back!(r, coordinates)

    cornerwalk(r, coordinates, West, Nord)
    go_back!(r, coordinates)

    cornerwalk(r, coordinates, Ost, Nord)
    go_back!(r, coordinates)

    cornerwalk(r, coordinates, Ost, Sud)
    go_back!(r, coordinates)
end

function cornerwalk(r::Robot, coordinates::Vector{Any}, side1::HorizonSide, side2::HorizonSide)
    while !(isborder(r, side1) && isborder(r, side2))
        if isborder(r, side1) == false
            move!(r, side1)
            push!(coordinates, side1)
        end
        if isborder(r, side2) == false
            move!(r, side2)
            push!(coordinates, side2)
        end
    end
    putmarker!(r)
end

all_corners_mark(r)
