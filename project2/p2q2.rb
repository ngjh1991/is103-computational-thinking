# Team ID: G3T2
# Team Member Name 1: NG JUN HONG ALEX
# Team Member Name 2: VIVIAN LAI WAN YIN

# Project 2 q2
# deadline: 5/Apr/2015 (Sun), 23:59hrs

def find_way(adj_matrix, origin, dest)

    if origin == dest
        return [origin]
    end

    infinity = 99999
    n = adj_matrix.length

    visited = Array.new(n, false)
    shortest_distances = Array.new(n, infinity)
    previous = Array.new(n, nil)
    pq = PriorityQueue.new()

    pq << [origin, 0]
    visited[origin] = true
    shortest_distances[origin] = 0

    current_val = 0
    i = 0
    current_distance = 0
    current_neighbours = []
    current_neighbour_at_i = 0

    while !pq.empty?
        current = pq.pop
        if !current
            break
        end
        current_val = current[0]

        if current_val == dest
            break
        end
        
        visited[current_val] = true
        current_neighbours = adj_matrix[current_val]

        for i in 0..current_neighbours.length-1
            current_neighbour_at_i = current_neighbours[i]
            if !current_neighbour_at_i.nil?
                if !visited[i]
                    current_distance = shortest_distances[current_val] + current_neighbour_at_i
                    if shortest_distances[i] > current_distance
                        shortest_distances[i] = current_distance
                        previous[i] = current_val
                        pq << [i, current_distance] # priority based on shortest distances
                    end
                end
            end
        end
    end
    result = [dest]
    previous_val = previous[dest]
    while !previous_val.nil?
        result << previous_val
        previous_val = previous[previous_val]
    end

    if result.length <= 1
        return nil
    end

    return result.reverse!
end

class PriorityQueue

    # default size will be 1
    def initialize
        @elements = []
    end

    def empty?
        return @elements.empty?
    end

    def <<(element)
        @elements << element
        bubble_up(@elements.length - 1)
    end

    def pop
        exchange(1, @elements.length - 1)
        max = @elements.pop
        bubble_down(1)
        return max
    end

    private

    def bubble_up(index)
        parent_index = (index / 2)

        if index <= 1
            return
        end
        if @elements[parent_index][1] <= @elements[index][1]
            return
        end

        exchange(index, parent_index)
        bubble_up(parent_index)
    end

    def bubble_down(index)
        child_index = (index * 2)

        if child_index > @elements.length - 1
            return
        end

        not_the_last_element = child_index < @elements.length - 1
        left_element = @elements[child_index]
        right_element = @elements[child_index + 1]
        if not_the_last_element && right_element[1] < left_element[1]
            child_index += 1
        end

        if @elements[index][1] <= @elements[child_index][1]
            return
        end

        exchange(index, child_index)
        bubble_down(child_index)
    end

    def exchange(source, target)
        @elements[source], @elements[target] = @elements[target], @elements[source]
    end
end