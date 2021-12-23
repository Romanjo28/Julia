function try_move!(robot, side)::Bool
    if isborder(robot, side) 
        false
    else
        move!(robot, side) 
        true
    end
end

function kross_n_na_n(r::Robot, n::Int)
    while !(isborder(r, Nord))
    
        first(r)
        
        second(r)
        
    end
end
        
function first(r)
    for i in 1:n
        while !(isborder(r, Ost))
            for i in 1:n
                putmarker!(r)
                try_move!(r, Ost)
            end

            for i in 1:n
                try_move!(r, Ost)
            end
        end

        while !(isborder(r, West))
            move!(r, West)
        end
        try_move!(r, Nord) 
    end
end 

function second(r)
    for i in 1:n
        while !(isborder(r, Ost))
            for i in 1:n
                try_move!(r, Ost)
            end

            for i in 1:n
                putmarker!(r)
                try_move!(r, Ost)
            end

            
        end

        while !(isborder(r, West))
            move!(r, West)
        end
        try_move!(r, Nord) 
    end
end 

kross_n_na_n(r, 3)
        
