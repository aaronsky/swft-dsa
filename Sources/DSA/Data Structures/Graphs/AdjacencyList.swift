//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/20/19.
//

public class AdjacencyList<Element: Hashable>: Graph {
    private var adjacencies: [Vertex<Element>: [Edge<Element>]] = [:]

    public init() {

    }

    public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }

    public func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }

    public func edges(from source: Vertex<Element>) -> [Edge<Element>] {
        return adjacencies[source] ?? []
    }

    public func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        return edges(from: source).first(where: { $0.destination == destination })?.weight
    }
}

extension AdjacencyList: CustomStringConvertible {
    public var description: String {
        var result = ""
        for (vertex, edges) in adjacencies {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ]\n")
        }
        return result
    }
}
