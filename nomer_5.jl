function all_corners_mark(r::Robot)
    coordinates = []
    cornerwalk(r, coordinates)
    paint!(r)
    go_back!(r, coordinates)
end

function paint!(r::Robot)
    for side in (Nord, Ost, Sud, West)
        moves!(r, side)
        putmarker!(r)
    end
end

function cornerwalk(r::Robot, coordinates::Vector{Any})
    while !(isborder(r, West) && isborder(r, Sud))
        if isborder(r, West) == false
            move!(r, West)
            push!(coordinates, West)
        end
        if isborder(r, Sud) == false
            move!(r, Sud)
            push!(coordinates, Sud)
        end
    end
end

all_corners_mark(r)

