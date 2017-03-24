# Team ID: G3T2
# Team Member Name 1: NG JUN HONG ALEX
# Team Member Name 2: VIVIAN LAI WAN YIN

# Project 2 q3
# deadline: 5/Apr/2015 (Sun), 23:59hrs

def plan_tour(adj_matrix, node_value, node_time, origin, dest, time_limit)

    if origin == dest
        return [origin]
    end

    n = adj_matrix.length

    i = 0
    current_distance = 0
    current_neighbours = []
    current_neighbour_at_i = 0

    dest_found = false
    new_node = false
    skipped = false

    visited_count = 1
    
    time_consumed = 0
    time_to_add = 0
    final_path = []
    neighbours_values = {}
    neighbours_values_arr = []
    visited = Array.new(n) { Array.new(n, false) }
    final_path << origin
    current_neighbour_at_i_node = 0
    last_node = origin

    arr = []
    for arr in visited
        arr[origin] = true
    end
    visited_length = visited.length * visited.length

    while !dest_found && visited_count != visited_length
        skipped = false
        new_node = false
        neighbours_values = {}

        current_neighbours = adj_matrix[last_node]
        for i in 0..current_neighbours.length-1
            current_neighbour_at_i = current_neighbours[i]
            if !current_neighbour_at_i.nil?
                if !visited[last_node][i]
                    neighbours_values[i] = (node_value[i].to_f / (adj_matrix[last_node][i] + node_time[i]))
                end
            end
        end

        neighbours_values_arr = neighbours_values.sort_by { |k, v| -v }

        for i in 0..neighbours_values_arr.length-1
            current_neighbour_at_i = neighbours_values_arr[i]
            current_neighbour_at_i_node = current_neighbour_at_i[0]

            if current_neighbour_at_i_node == dest
                skipped = true
                next
            end
            if !visited[last_node][current_neighbour_at_i_node]
                if !final_path.include?(current_neighbour_at_i_node)
                    time_to_add = node_time[current_neighbour_at_i_node] + adj_matrix[last_node][current_neighbour_at_i_node]
                    if time_consumed + time_to_add <= time_limit
                        time_consumed += time_to_add
                        final_path << current_neighbour_at_i_node
                        visited[last_node][current_neighbour_at_i_node] = true
                        visited_count += 1
                        last_node = current_neighbour_at_i_node
                        new_node = true
                        break
                    end
                end
            end
        end
        if skipped
            if !new_node
                time_consumed += adj_matrix[final_path.last][dest]
                final_path << dest
                if time_consumed > time_limit
                    final_path.pop
                    time_consumed -= adj_matrix[final_path.last][dest]
                else
                    break
                end
            end
        end
        if !new_node
            popped = final_path.pop
            last_node = final_path.last
            if last_node.nil?
                return nil
            end
            time_consumed -= (node_time[popped] + adj_matrix[final_path.last][popped])
        end
        dest_found = (last_node == dest)
    end

    if time_consumed > time_limit
        return nil
    else
        return final_path
    end
end