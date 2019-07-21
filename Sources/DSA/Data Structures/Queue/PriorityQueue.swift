//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/20/19.
//

struct PriorityQueue<Element: Equatable>: Queue {
    private var heap: Heap<Element>

    var isEmpty: Bool {
        return heap.isEmpty
    }

    init(sortedBy areInIncreasingOrder: @escaping (Element, Element) -> Bool, contentsOf elements: [Element] = []) {
        heap = Heap(sortedBy: areInIncreasingOrder, contentsOf: elements)
    }

    @discardableResult
    mutating func enqueue(_ element: Element) -> Bool {
        heap.push(element)
        return true
    }

    func peek() -> Element? {
        return heap.peek()
    }

    @discardableResult
    mutating func dequeue() -> Element? {
        return heap.pop()
    }
}
