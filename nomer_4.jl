function putmarkers1!(r::Robot,side::HorizonSide,num_steps::Int)
    if isborder(r,side)==false
        move!(r,side)
    elseif isborder(r,side)==true
        k=0
        while isborder(r,side)==true
            move!(r,Nord)
            k+=1
        end
        move!(r,side)
        if isborder(r,Sud)==true
            move!(r,side)
        end
        for _ in 1:k
            move!(r,Sud)
        end            
    end
    go_and_obhod(r,side,num_steps)
    putmarker!(r)
    if isborder(r,Nord)==false
        move!(r,Nord)
    end
end
