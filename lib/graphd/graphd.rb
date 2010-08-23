module Graphd
  class Graph
    
    # Initialize an empty graph
    def initialize()
      @graph = {}
    end
      
    # Add a vertext to the graph. Vertex can be any object
    def add_vertex(vertex)
      @graph[vertex] = []
      self
    end

    # Add an edge between vertex1 and vertex2. The edge is bidirectional.
    # Raises InvalidEdgeException if either vertex1 or 2 don't exist.
    def add_edge(vertex1, vertex2)
      if !@graph[vertex1] || !@graph[vertex2]
        raise InvalidVertexException, "That vertex doesn't exist in the graph"
      end
      @graph[vertex1].push(vertex2)
      @graph[vertex2].push(vertex1)
      self
    end

    # Return the value. Since the node is an object now just return the object itself
    def get_node_value(node)
      node
    end

    # Tests to see if vertex1 and vertex2 are adjacent to eachother
    def adjacent(vertex1, vertex2)
      connections = @graph[vertex1]
      return connections && connections.include?(vertex2)
    end

    # Returns an array of the neighboring nodes to the passed in vertext
    def neighbors(vertex)
      @graph[vertex] || []
    end

    # Delete a vertex from the graph
    def delete_vertex(vertex)
      if !contains_vertex?(vertex)
        raise InvalidVertexException, "The graph does not contain that vertex"
      end
      
      # Need to make a copy of the graph since it's being edited in place
      Array.new(@graph[vertex]).each { |connection| delete_edge(connection, vertex) }
      @graph.delete(vertex)
      self
    end
    
    # Delete an edge from the graph
    def delete_edge(vertex1, vertex2)
      if !contains_vertex?(vertex1) || !contains_vertex?(vertex2)
        raise InvalidVertexException, "The graph does not contain that vertex"
      elsif !(@graph[vertex1].include?(vertex2))
        raise InvalidEdgeException, "The graph does not contain that edge"        
      end
      @graph[vertex1].delete(vertex2)
      @graph[vertex2].delete(vertex1)
      self
    end

    # Counts the number of verticies
    def vertex_count
      @graph.length
    end

    # Prints out a string representation of the graph
    def to_s
      res = ""
      @graph.each_pair do |key, value|
        res += key.to_s + ": " + value.join(', ') + "\n"
      end
      res
    end

    # Perform a depth first search on the graph for the given vertex
    def dfs(target)
      visited = {}
      @graph.keys.each { |key| visited[key] = false }
      node = @graph.keys[0]
      res = search_dfs(node, target, visited)      
    end

    # Perform a bredth first search on the graph for the given vertex
    def bfs(target)
      visited = {}
      @graph.keys.each { |key| visited[key] = false }
      node = @graph.keys[0]
      queue = Queue.new
      queue << node
      while !(queue.length == 0)
        visited[node] = true
        puts "node is #{node}"
        return node if node == target
        @graph[node].each do |nabe|
          queue << nabe unless visited[nabe] == true
        end
        node = queue.pop
      end
    end
    
  private
    def contains_vertex?(vertex)
      @graph[vertex] ? true : false
    end

    # Perform a depth first search algorithm
    def search_dfs(node, target, visited)
      return if visited[node] == true
      return node if node == target
      visited[node] = true
      res = nil
      @graph[node].each do |nabe|
        if !visited[nabe]
          if (res = search_dfs(nabe, target, visited)) == target
            break
          end
        end
      end
      res
    end
  end
  
  def search_bfs(node, target, visited)
    
  end
end
