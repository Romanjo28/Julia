using HorizonSideRobots
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function find_prohod(r::Robot, side::HorizonSide)
    counter = 1 
    while (isborder(r, Nord))==true 
        for i in 1:counter 
            move!(r, side)
            if !(isborder(r, Nord))
                break 
            end
        end

        if !(isborder(r, Nord))
            break 
        end 

        counter += 1

        for i in 1:counter 
            move!(r, inverse(side))
            if !(isborder(r, Nord))
                break 
            end
        end
        counter += 1
    end
end 

find_prohod(r, Ost)
