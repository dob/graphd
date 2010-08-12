require 'test/unit'
require 'graphd'

class GraphdTest < Test::Unit::TestCase
  def setup
    @graph = Graphd::Graph.new
    @graph.add_vertex(1)
    @graph.add_vertex(2)
    @graph.add_vertex(3)
    @graph.add_vertex(4)
    @graph.add_vertex(5)
  end

  def test_add_vertex
    assert @graph.vertex_count == 5
    @graph.add_vertex(6)
    assert @graph.vertex_count == 6
  end

  def test_add_edge
    @graph.add_edge(1,2)
    assert @graph.connected(1, 2)
  end

  def test_bad_connection
    assert !@graph.connected(1,3)
  end

end
