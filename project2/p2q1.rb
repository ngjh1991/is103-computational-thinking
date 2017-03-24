# Team ID: G3T2
# Team Member Name 1: NG JUN HONG ALEX
# Team Member Name 2: VIVIAN LAI WAN YIN

# Project 2 q1
# deadline: 5/Apr/2015 (Sun), 23:59hrs

def lightning(a, y, x)
    if a[y][x] == 0
        return a
    end

    if a[y][x] == 1
        a[y][x] = 0
    end

    if y-1 != -1
        a = lightning(a, y-1, x)
    end

    if y+1 != a.length
        a = lightning(a, y+1, x)
    end

    if x-1 != -1
        a = lightning(a, y, x-1)
    end

    if x+1 != a[0].length
        a = lightning(a, y, x+1)
    end

    return a
end