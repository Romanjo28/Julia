using HorizonSideRobots

function q(r::Robot, side::HorizonSide)
    while !(isborder(r, side))
        putmarker!(r)
        move!(r, side)
        move!(r,side)
    end
end

function step_verh(r::Robot, side::HorizonSide)
    if ismarker(r)==false
        move!(r, Nord)
    end
    
    if ismarker(r)==true
        move!(r, Nord)
        move!(r, side)
    end
end

function mark_2(r::Robot) 
    while (isborder(r, Nord)==false && isborder(r, Ost)==false) 
        function q(r, Ost)
        function step_verh(r, West)
        function q(r, West)
        function step_verh(r, Ost)
    end
end

mark_2(r)
