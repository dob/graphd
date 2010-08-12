module Graphd
  VERSION = '0.1.0'
  
  # Raised when vertex doesn't exist in the graph
  class InvalidEdgeException < Exception
  end
  
  # Raised when the vertex doesn't exist in the graph
  class InvalidVertexException < Exception
  end
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'graphd', 'graphd')
