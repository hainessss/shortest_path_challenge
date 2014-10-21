require 'pry-byebug'


class Graph
  attr_accessor :paths, :directory

  def initialize
    @paths = []
    @directory = {}
  end

  def insert_node(destination)
    @directory[destination] = Node.new(destination)
  end

  #creates a road edge and adds the edge to the correspnonding node city objects
  def insert_edge(destination1, destination2, distance)
    node1 = @directory[destination1]
    node2 = @directory[destination2]

    edge = Edge.new(node1, node2, distance)

    node1.edges[destination2] = edge
    node2.edges[destination1] = edge

    edge
  end

  #recusively travels through paths returning at visited cities
  #and the destination. adds the paths from the different call stacks to instance variable 'paths'
  def traverse_paths(current_node, destination, path=[], distance=0)
    path1 = []
    path.each do |x|
      path1 << x
    end

    if path1.include?(current_node.value)
      return
    end

    path1 << current_node.value

    if current_node == destination
      result = {
        'path' => path1,
        'distance' => distance
      }
      @paths << result
      return
    end

    current_node.edges.each do |key, val|
      distance_added = current_node.edges[key].distance
      distance += distance_added

      node = identify_direction(current_node.edges[key], current_node)

      traverse_paths(node, destination, path1, distance)
    end
  end

  #determines what city the function is currently in and
  #returns the other city in the edge as the next destination
  def identify_direction(edge, node)
    if edge.node1 = node
      return edge.node2
    else
      return edge.node1
    end
  end

  #wrapper function to facilitate finding the shortest path
  def find_shortest_path(start, destination)
    @paths = []

    start = @directory[start]
    destination = @directory[destination]

    traverse_paths(start, destination)

    return examine_paths(@paths)
  end

  #helper function to examine the results of traversing the paths
  def examine_paths(result)
    best_path = {'distance' => 1.0/0 }

    result.each do |path|
      if path['distance'] < best_path['distance']
        best_path = path
      end
    end

    best_path
  end
end

class Edge
  attr_accessor :node1, :node2, :distance

  def initialize(node1, node2, distance)
    @node1 = node1
    @node2 = node2
    @distance = distance
  end
end

class Node
  attr_accessor :value, :edges

  def initialize(value)
    @value = value
    @edges = {}
  end
end
