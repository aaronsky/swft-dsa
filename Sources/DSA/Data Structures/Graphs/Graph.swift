//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/20/19.
//

import Foundation

public struct Vertex<Element> {
    public let index: Int
    public let data: Element
}
extension Vertex: Hashable where Element: Hashable {}
extension Vertex: Equatable where Element: Equatable {}
extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(index): \(data)"
    }
}

public struct Edge<Element> {
    public let source: Vertex<Element>
    public let destination: Vertex<Element>
    public let weight: Double?
}

public enum EdgeType {
    case directed
    case undirected
}

public protocol Graph {
    associatedtype Element

    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func addUndirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

public extension Graph {
    func addUndirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }

    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(from: source, to: destination, weight: weight)
        }
    }
}

public extension Graph where Element: Hashable {
    /// O(V + E)
    func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue: QueueStack<Vertex<Element>> = [source]
        var enqueued: Set<Vertex<Element>> = [source]
        var visited: [Vertex<Element>] = []

        while let vertex = queue.dequeue() {
            visited.append(vertex)

            let neighborEdges = edges(from: vertex)
            for edge in neighborEdges where !enqueued.contains(edge.destination) {
                queue.enqueue(edge.destination)
                enqueued.insert(edge.destination)
            }
        }

        return visited
    }

    /// O(V + E)
    func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var stack: [Vertex<Element>] = [source]
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []

        while let vertex = stack.popLast() {
            if pushed.contains(vertex) {
                continue
            }

            pushed.insert(vertex)
            visited.append(vertex)

            for neighbor in self.edges(from: vertex) {
                stack.append(neighbor.destination)
            }
        }

        return visited
    }
}
