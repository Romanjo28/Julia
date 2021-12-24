using HorizonSideRobots

"""
    moves!(r::Robot, side::HorizonSide)

-- Перемещает робота до упора в заданном направлении
"""
function moves!(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
    end
end

"""
    moves!(r::Robot, side::HorizonSide, num_steps::Int)

-- Перемещает робота в направлении side на заданное число шагов
"""
function number_move_put!(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
        putmarker!(r)
    end
end

"""
    putmarkers!(r::Robot, side::HorizonSide)

-- Ставит маркеры всюду в заданном направлении, пока робот не встретит перегородку,
   исключая начальную позицию
"""
function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
    end
end
function move_by_markers(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        move!(r, side)
    end
end


"""
    inverse(side::HorizonSide)

-- Возвращает направление, противоположное заданному
"""
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

"""

    cornerwalk(r::Robot, coordinates(название любого массива, в этом случае такой))

-- Идет в угол
"""
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

"""

    go_back(r::Robot, coordinates)

---возвращается обратно из угла, дополнение к прошлой функции, ставить после всех махинаций
"""
function go_back!(r::Robot, coordinates)
    while length(coordinates) > 0
        side = pop!(coordinates)
        move!(r, inverse(side))
    end
end


"""

    mark_perimetr!(r::Robot, side::HorizonSide)

---маркирует фигуру (квадрад, прямоугольник, линия) по кругу с заданным начальным направлением 
"""

function mark_perimetr!(r::Robot, side::HorizonSide)
    if side == Nord
        mov = (Nord, Ost, Sud, West)
        bord = (Ost, Sud, West, Nord)
    else
        mov = (Sud, Ost, Nord, West)
        bord = (Ost, Nord, West, Sud)
    end
    for i in 1:4
        while isborder(r, bord[i]) == true
            putmarker!(r)
            move!(r, mov[i])
        end
        putmarker!(r)
        if i < 4
            move!(r, mov[i+1])
        else
            move!(r, Sud)
        end
    end
end

"""

find_mrk_spiral(r::Robot)

--ходит спиралью и ищет маркер  
"""

function find_mrk_spiral(r)

    counter = 1 
    while ismarker(r)==false
        
        for i in 1:counter 
            move!(r, Ost)
            if ismarker(r)==true 
                break
            end
        end
        if ismarker(r)==true 
            break
        end
    
        
        for i in 1:counter 
            move!(r, Nord)
            if ismarker(r)==true 
                break
            end
        end 
        if ismarker(r)==true 
            break
        end

        counter += 1 

        for i in 1:counter 
            move!(r, West)
            if ismarker(r)==true 
                break
            end
        end
        if ismarker(r)==true 
            break
        end
        
        for i in 1:counter 
            move!(r, Sud)
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

"""
    go_to_corner!(x::Robot, mvs::AbstractArray)
-- Перемещает Робота в любой угол, обходя препядствия, и записывает путь в массив
"""
function go_to_corner!(x::Robot, mvs::AbstractArray)
    while (!isborder(x, side1) || !isborder(x, side2))
        if !isborder(x, side1)
            moves!(x, side1, mvs)
        else
            moves!(x, side2, mvs)

        end
    end
end


function moves1!(r::Robot,side::HorizonSide,num_steps::Int)
    q=0
    while q<num_steps 
        if isborder(r,Nord)==true
            while isborder(r,side)==true
                move!(r,Ost)
            end
            move!(r,Nord)
            q+=1
            if isborder(r,West)==true
                while isborder(r,West)==true
                    move!(r,Nord)
                    q+=1
                end
            end
            move!(r,West)
        end
        if q<num_steps
        move!(r,side)
        q+=1
        end
    end
end


"""
obhod(r::Robot,side::HorizonSide)
-- Обходит препядствие на своем пути 
"""

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

"""
go_and_obhod(r::Robot,side::HorizonSide,num_steps::Int)
-- Будет делать треугольник и обходить препядствия на своем пути 
"""

function go_and_obhod(r::Robot,side::HorizonSide,num_steps::Int)
    q=0
    k=0
    while q<num_steps
        k=0
       putmarker!(r)
       if isborder(r,side)==false
            move!(r,side)
            q+=1
       else isborder(r,side)==true
            while isborder(r,side)==true
                move!(r,Nord)
                k+=1
            end
            move!(r,side)
            q+=1
            if isborder(r,Sud)==true
                move!(r,side)
                q+=1
            end
            for _ in 1:k
                move!(r,Sud)
            end            
       end
    end
end

"""
go_to_border_and_return_path!(r::Robot, side::HorizonSide; go_around_barriers::Bool = false, markers = false)::Array{Tuple{HorizonSide,Int64},1}
Перемещает робота до границы и возвращает путь для обраного следования в виде массива пар типа (направление, количество шагов)
Именованные параметры: 
go_around_barriers - робот будет по пути обходить перегородки, если такие имеются;
markers - робот будет ставить маркеры по пути (не ставит их при обходе перегородок).
"""
function go_to_border_and_return_path!(r::Robot, side::HorizonSide; go_around_barriers::Bool = false, markers = false)::Array{Tuple{HorizonSide,Int64},1}
    my_ans = [ (Nord, 0) ]
    if go_around_barriers
        steps = 0
        if markers
            putmarker!(r)
        end
        if !isborder(r, side)
            move!(r, side)
            steps = 1
            push!(my_ans, (inverse_side(side), 1) )
        else
            path = go_around_barrier_and_return_path!(r, side)
            steps = get_path_length_in_direction(path, side)
            for i in path
                push!(my_ans, i)
            end
        end
        if markers
            putmarker!(r)
        end
        while steps > 0
            if !isborder(r, side)
                move!(r, side)
                steps = 1
                push!(my_ans, (inverse_side(side), 1) )
                if markers
                    putmarker!(r)
                end
            else
                path = go_around_barrier_and_return_path!(r, side)
                steps = get_path_length_in_direction(path, side)
                for i in path
                    push!(my_ans, i)
                end
                if markers
                    putmarker!(r)
                end
            end
        end

    else
        steps=0
        steps_now = go!(r,side; markers)
        while steps_now > 0
            steps += steps_now
            steps_now = go!(r,side; markers)
        end
        push!(my_ans, (inverse_side(side), steps) )
    end
    return my_ans
end


function go!(r::Robot, side::HorizonSide; steps::Int = 1, go_around_barriers::Bool = false, markers = false)::Int
    my_ans = 0
    if markers
        putmarker!(r)
    end
    if (go_around_barriers)
        path = around_move_return_path!(r, side; steps, markers)
        my_ans = get_path_length_in_direction(path, side)
    else
        for i ∈ 1:steps

            if (markers)
                putmarker!(r)
            end

            if !isborder(r, side)
                move!(r, side)
                my_ans += 1
            else
                for i ∈ 1:my_ans
                    move!(r, inverse_side(side))
                end
                my_ans = 0
                break
            end
        end
        if (markers)
            putmarker!(r)
        end
    end

    return my_ans
end
