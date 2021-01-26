//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/20/19.
//

public enum Visit<Element: Hashable> {
    case start
    case edge(Edge<Element>)
}

public extension Graph where Element: Hashable {
    typealias PathMap = [Vertex<Element>: Visit<Element>]

    /// O(E log V)
    func shortestPath(from start: Vertex<Element>) -> PathMap {
        var paths: PathMap = [start: .start]

        var priorityQueue = PriorityQueue<Vertex<Element>>(sortedBy: {
            self.distance(to: $0, with: paths) < self.distance(to: $1, with: paths)
        }, contentsOf: [start])

        while let vertex = priorityQueue.dequeue() {
            for edge in edges(from: vertex) {
                guard let weight = edge.weight else {
                    continue
                }
                if paths[edge.destination] == nil || distance(to: vertex, with: paths) + weight < distance(to: edge.destination, with: paths) {
                    paths[edge.destination] = .edge(edge)
                    priorityQueue.enqueue(edge.destination)
                }
            }
        }

        return paths
    }

    func shortestPath(to destination: Vertex<Element>, paths: PathMap) -> [Edge<Element>] {
        return route(to: destination, with: paths)
    }

    private func route(to destination: Vertex<Element>, with paths: PathMap) -> [Edge<Element>] {
        var vertex = destination
        var path: [Edge<Element>] = []

        while let visit = paths[vertex], case .edge(let edge) = visit {
            path = [edge] + path
            vertex = edge.source
        }
        return path
    }

    private func distance(to destination: Vertex<Element>, with paths: PathMap) -> Double {
        let path = route(to: destination, with: paths)
        let distances = path.compactMap { $0.weight }
        return distances.reduce(0.0, +)
    }
}
