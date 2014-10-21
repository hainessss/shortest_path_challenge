require 'rspec'
require_relative '../ruby.rb'


describe Graph do
  describe 'insert_node' do
    it 'should add a new city node to the graph' do
      map = Graph.new()

      map.insert_node('menlo')

      expect(map.directory['menlo']).to be_a Node
      expect(map.directory['menlo'].value).to eq 'menlo'
    end
  end

  describe 'insert_edge' do
    it 'should add new road edge to the graph' do
      map = Graph.new()

      city1 = map.insert_node('menlo')
      city2 = map.insert_node('san francisco')

      edge1 = map.insert_edge('menlo', 'san francisco', 20)

      expect(edge1).to be_a Edge
      expect(edge1.node1).to eq city1
      expect(edge1.node2).to eq city2
      expect(edge1.distance).to eq 20
      expect(city1.edges['san francisco']).to eq edge1
      expect(city2.edges['menlo']).to eq edge1
    end
  end

  describe 'find_shortest_path' do
    it 'should return a list of the shortest path and its distance' do
      map = Graph.new()

      map.insert_node('menlo')
      map.insert_node('san francisco')
      map.insert_node('oakland')
      map.insert_node('san rafael')
      map.insert_node('petaluma')
      map.insert_edge('menlo', 'san francisco', 20)
      map.insert_edge('san francisco', 'san rafael', 15)
      map.insert_edge('san francisco', 'oakland', 10)
      map.insert_edge('oakland', 'san rafael', 20)
      map.insert_edge('san rafael', 'petaluma', 20)

      result = map.find_shortest_path('menlo', 'petaluma')

      expect(result['path']).to eq ['menlo','san francisco','san rafael','petaluma']
      expect(result['distance']).to eq 110
    end
  end

end
