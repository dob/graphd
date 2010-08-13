require 'test/unit'
require 'graphd'

class GraphdTest < Test::Unit::TestCase

  def test_add_vertex
    graph = make_graph
    assert graph.vertex_count == 5
    graph.add_vertex(6)
    assert graph.vertex_count == 6
  end

  def test_add_edge
    graph = make_graph
    graph.add_edge(1,2)
    assert graph.adjacent(1, 2)
  end
  
  def test_add_invalid_edge
    graph = make_graph
    assert_raise Graphd::InvalidVertexException do
      graph.add_edge(1, 9)
    end
  end

  def test_not_adjacent
    graph = make_graph
    assert !graph.adjacent(1,3)
  end

  def test_adjacent
    graph = make_graph
    assert !graph.adjacent(1,3)
    graph.add_edge(2,4)
    assert graph.adjacent(2,4)
  end

  def test_neighbors
    graph = make_graph
    assert graph.neighbors(2) == []
    graph.add_edge(2, 3)
    graph.add_edge(2, 4)
    graph.add_edge(2, 5)
    assert graph.neighbors(2) == [3,4,5]
  end

  def test_delete
    graph = make_graph
    graph.add_edge(1, 5)
    assert graph.delete_edge(5, 1)
  end

  def test_invalid_delete
    graph = make_graph

    assert_raise Graphd::InvalidEdgeException do 
      graph.delete_edge(1, 4)
    end

    assert_raise Graphd::InvalidVertexException do
      graph.delete_edge(1, 6) 
    end

  end

  def test_delete_vertex
    graph = make_graph
    graph.add_edge(1,4)
    assert graph.neighbors(1).include?(4)
    graph.delete_vertex(4)
    assert !graph.neighbors(1).include?(4)
  end

  def test_delete_vertex2
    graph = make_graph
    graph.add_edge(1,3).
      add_edge(1,4).
      add_edge(2,3)
    graph.delete_vertex(1)
    assert graph.neighbors(4).empty?
  end

  def test_dfs
    graph = make_graph
    graph.add_edge(1,2).
      add_edge(2,3).
      add_edge(3,5).
      add_edge(1,4)
    #puts graph.dfs(8).to_s + " is what you get at 8"
    assert_nil graph.dfs(8)
    assert_equal graph.dfs(4), 4
  end

private

  def make_graph
    graph = Graphd::Graph.new
    graph.add_vertex(1)
    graph.add_vertex(2)
    graph.add_vertex(3)
    graph.add_vertex(4)
    graph.add_vertex(5)
    graph
  end
end
