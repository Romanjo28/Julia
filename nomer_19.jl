using HorizonSideRobots 

function obhod(r::Robot,side::HorizonSide)
    k=0
    j=0
    while isborder(r,side)==true && isborder(r,next(side))==false
        move!(r,next(side)) 
        k+=1   
    end
    if isborder(r,side)==true && isborder(r,next(side))==true
        for _ in 1:k
            move!(r,inverse(next(side)))
        end
        k=0
    end
    while isborder(r,side)==true && isborder(r,inverse(next(side)))==false
        move!(r,inverse(next(side))) 
        j+=1   
    end
    if isborder(r,side)==true && isborder(r,inverse(next(side)))==true
        for _ in 1:j
            move!(r,next(side))
        end
    end
    if k==0
        k=j
        side1 = next(side)
    else
        side1 = inverse(next(side))
    end
    if isborder(r,side)==false
        print(side)
        move!(r,side)
        while (isborder(r,next(inverse(side)))==true &&(isborder(r,next(side))==false || isborder(r,inverse(next(side)))==false))
            move!(r,side)
        end
        for _ in 1:k
            move!(r,side1) 
        end
    end
end

function find_mrk_spiral(r)

counter = 1 
while ismarker(r)==false
    
    for i in 1:counter 
        obhod(r, Ost)
        if ismarker(r)==true 
            break
        end
    end
    if ismarker(r)==true 
        break
    end

    
    for i in 1:counter 
        obhod(r, Nord)
        if ismarker(r)==true 
            break
        end
    end 
    if ismarker(r)==true 
        break
    end

    counter += 1 

    for i in 1:counter 
        obhod(r, West)
        if ismarker(r)==true 
            break
        end
    end
    if ismarker(r)==true 
        break
    end
    
    for i in 1:counter 
        obhod(r, Sud)
        if ismarker(r)==true 
            break
        end
    end 
    if ismarker(r)==true 
        break
    end
    
    counter += 1 

end 
end 

find_mrk_spiral(r)
