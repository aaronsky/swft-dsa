//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/20/19.
//

import Foundation

public class AdjacencyMatrix<Element>: Graph {
    private var vertices: [Vertex<Element>] = []
    private var weights: [[Double?]] = []

    public init() {

    }

    public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex)
        for i in 0..<weights.count {
            weights[i].append(nil)
        }
        let row = [Double?](repeating: nil, count: vertices.count)
        weights.append(row)
        return vertex
    }

    public func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }

    public func edges(from source: Vertex<Element>) -> [Edge<Element>] {
        var edges: [Edge<Element>] = []
        for column in 0..<weights.count {
            if let weight = weights[source.index][column] {
                edges.append(Edge(source: source, destination: vertices[column], weight: weight))
            }
        }
        return edges
    }

    public func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        return weights[source.index][destination.index]
    }
}

extension AdjacencyMatrix: CustomStringConvertible {
    public var description: String {
        let verticesDescription = vertices.map(String.init).joined(separator: "\n")
        var grid: [String] = []
        for i in 0..<weights.count {
            var row = ""
            for j in 0..<weights.count {
                if let value = weights[i][j] {
                    row += "\(value)\t"
                } else {
                    row += "ø\t\t"
                }
            }
            grid.append(row)
        }
        let edgesDescription = grid.joined(separator: "\n")
        return "\(verticesDescription)\n\n\(edgesDescription)"
    }
}
