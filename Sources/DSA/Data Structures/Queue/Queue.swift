//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/20/19.
//

public protocol Queue {
    associatedtype Element

    var isEmpty: Bool { get }
    mutating func enqueue(_ element: Element) -> Bool
    func peek() -> Element?
    mutating func dequeue() -> Element?
}

public struct QueueArray<Element>: Queue {
    private var array: [Element] = []

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public init() {

    }

    /// O(1)
    @discardableResult
    public mutating func enqueue(_ element: Element) -> Bool {
        array.append(element)
        return true
    }

    public func peek() -> Element? {
        return array.first
    }

    /// O(n)
    @discardableResult
    public mutating func dequeue() -> Element? {
        return isEmpty ? nil : array.removeFirst()
    }
}

public class QueueLinkedList<Element>: Queue {
    private var list = SinglyLinkedList<Element>()

    public var isEmpty: Bool {
        return list.isEmpty
    }

    public init() {

    }

    /// O(1)
    @discardableResult
    public func enqueue(_ element: Element) -> Bool {
        list.append(element)
        return true
    }

    public func peek() -> Element? {
        return list.head?.value
    }

    /// O(1)
    @discardableResult
    public func dequeue() -> Element? {
        guard !list.isEmpty, let head = list.head else {
            return nil
        }
        let element = head.value
        list.remove(node: head)
        return element
    }
}

public struct QueueStack<Element>: Queue {
    private var leftStack: [Element] = []
    private var rightStack: [Element] = []

    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }

    public init() {

    }

    /// O(1)
    @discardableResult
    public mutating func enqueue(_ element: Element) -> Bool {
        rightStack.append(element)
        return true
    }

    public func peek() -> Element? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
    }

    /// O(n)
    @discardableResult
    public mutating func dequeue() -> Element? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
}

extension QueueStack: ExpressibleByArrayLiteral {
    public init(arrayLiteral: Element...) {
        self = .init()
        for el in arrayLiteral {
            self.enqueue(el)
        }
    }
}
