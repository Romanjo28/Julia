using HorizonSideRobots
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))


function counter(r::Robot)
    side=Ost
    num=0
    while isborder(r,Nord)==false
        while isborder(r,side)==false
            if borders(r,side)==true
                num+=1
                walk_by(r,side)
            end
        end
        move!(r,Nord)
        side=inverse(side)
    end
    return num
end

function borders(r::Robot,side::HorizonSide) 
    while isborder(r,Nord)==false 
        if isborder(r,side)==true
            return false
        end
        move!(r,side) 
    end
    return true
end

function walk_by(r::Robot,side::HorizonSide)
    while isborder(r,Nord)==true 
        move!(r,side) 
    end
end

counter(r)
