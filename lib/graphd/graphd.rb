module Graphd
  class Graph
    
    def initialize()
      @graph = {}
    end
      
    def add_vertex(vertex)
      @graph[vertex] = []
      self
    end

    def add_edge(vertex1, vertex2)
      if !@graph[vertex1] || !@graph[vertex2]
        raise InvalidEdgeException, "That vertex doesn't exist in the graph"
      end
      @graph[vertex1].push(vertex2)
      @graph[vertex2].push(vertex1)
      self
    end

    def to_s
      res = ""
      @graph.each_pair do |key, value|
        res += key.to_s + ": " + value.join(', ')
      end
      res
    end

    

  end
end
