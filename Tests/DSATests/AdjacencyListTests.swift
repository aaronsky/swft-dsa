//
//  File.swift
//  
//
//  Created by Aaron Sky on 8/25/19.
//

import XCTest
@testable import DSA

class AdjacencyListTests: XCTestCase {

    func testUndirected() {
        let graph = AdjacencyList<Int>()
        let one = graph.createVertex(data: 1)
        let two = graph.createVertex(data: 2)
        let three = graph.createVertex(data: 3)
        let four = graph.createVertex(data: 4)
        let five = graph.createVertex(data: 5)
        graph.addUndirectedEdge(from: one, to: two, weight: nil)
        graph.addUndirectedEdge(from: one, to: three, weight: nil)
        graph.addUndirectedEdge(from: three, to: four, weight: nil)
        graph.addUndirectedEdge(from: four, to: five, weight: nil)
        graph.add(.undirected, from: two, to: five, weight: nil)
        XCTAssertEqual(graph.breadthFirstSearch(from: one), [one, two, three, five, four])
        XCTAssertEqual(graph.depthFirstSearch(from: one), [one, three, four, five, two])
    }

    func testDirected() {
        let graph = AdjacencyList<Int>()
        let one = graph.createVertex(data: 1)
        let two = graph.createVertex(data: 2)
        let three = graph.createVertex(data: 3)
        let four = graph.createVertex(data: 4)
        let five = graph.createVertex(data: 5)
        graph.addDirectedEdge(from: one, to: two, weight: nil)
        graph.addDirectedEdge(from: one, to: three, weight: nil)
        graph.addDirectedEdge(from: three, to: four, weight: nil)
        graph.addDirectedEdge(from: four, to: five, weight: nil)
        graph.add(.directed, from: two, to: five, weight: nil)
        XCTAssertEqual(graph.breadthFirstSearch(from: one), [one, two, three, five, four])
        XCTAssertEqual(graph.depthFirstSearch(from: one), [one, three, four, five, two])
    }

    func testGraphWithWeight() {
        let graph = AdjacencyList<Int>()
        let one = graph.createVertex(data: 1)
        let two = graph.createVertex(data: 2)
        let three = graph.createVertex(data: 3)
        let four = graph.createVertex(data: 4)
        let five = graph.createVertex(data: 5)
        graph.addDirectedEdge(from: one, to: two, weight: 4.0)
        graph.addDirectedEdge(from: one, to: three, weight: 3.5)
        graph.addDirectedEdge(from: three, to: four, weight: 17.0)
        graph.addDirectedEdge(from: four, to: five, weight: 2.0)
        graph.addDirectedEdge(from: two, to: five, weight: 1.0)

        XCTAssertEqual(graph.weight(from: one, to: two), 4.0)
        XCTAssertEqual(graph.weight(from: one, to: three), 3.5)
        XCTAssertEqual(graph.weight(from: three, to: four), 17.0)
        XCTAssertEqual(graph.weight(from: four, to: five), 2.0)
        XCTAssertEqual(graph.weight(from: two, to: five), 1.0)
    }
}
