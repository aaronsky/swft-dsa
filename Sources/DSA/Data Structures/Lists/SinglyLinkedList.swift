//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/21/19.
//

final class SinglyLinkedList<Element> {
    typealias Index = Int

    class Node {
        var value: Element
        var next: Node?

        init(_ value: Element) {
            self.value = value
        }
    }

    var head: Node?
    var startIndex: Index {
        return 0
    }

    var tail: Node?
    var endIndex: Index {
        return count
    }

    var count: Int = 0

    var isEmpty: Bool {
        return head == nil && tail == nil
    }

    /// O(λ + μ)
    var hasCycle: Bool {
        if isEmpty || head === tail {
            return false
        }
        var tortoise = head
        var hare = head
        while hare != nil && tortoise != nil {
            if hare === tortoise {
                return true
            }
            hare = hare?.next?.next
            tortoise = tortoise?.next
        }
        return false
    }

    required init() {

    }

    /// O(n)
    func prepend(_ element: Element) {
        let newNode = Node(element)
        if isEmpty {
            head = newNode
            tail = newNode
            count += 1
            return
        }
        guard let head = head else {
            return
        }
        insert(node: newNode, before: head)
        self.head = newNode
    }

    /// O(n)
    func append(_ element: Element) {
        let newNode = Node(element)
        if isEmpty {
            self.head = newNode
            self.tail = newNode
            count += 1
            return
        }
        guard let tail = tail else {
            return
        }
        insert(node: newNode, after: tail)
        self.tail = newNode
    }

    /// O(n)
    func insert(_ element: Element, before index: Index) {
        if index <= startIndex {
            prepend(element)
            return
        } else if index >= endIndex {
            append(element)
            return
        }
        let newNode = Node(element)
        guard let rightNode = node(at: index)?.next else {
            // reevaluate this silent failure
            return
        }
        insert(node: newNode, before: rightNode)
    }

    /// O(n)
    func insert(_ element: Element, after index: Index) {
        if index <= startIndex {
            prepend(element)
            return
        } else if index >= endIndex {
            append(element)
            return
        }
        let newNode = Node(element)
        guard let leftNode = node(at: index) else {
            // reevaluate this silent failure
            return
        }
        insert(node: newNode, after: leftNode)
    }

    /// O(n)
    func insert(node: Node, before right: Node) {
        let left = self.node(before: right)
        left?.next = node
        node.next = right
        count += 1
    }

    /// O(1)
    func insert(node: Node, after left: Node) {
        let right = left.next
        left.next = node
        node.next = right
        count += 1
    }

    /// O(n)
    func remove(node: Node) {
        if node === head {
            head = node.next
        }
        guard let leftNode = self.node(before: node) else {
            return
        }
        leftNode.next = node.next
        if node === tail {
            tail = leftNode
        }
        node.next = nil
        count -= 1
    }

    /// O(n)
    func removeElement(at index: Index) {
        guard let node = node(at: index) else {
            return
        }
        remove(node: node)
    }

    /// O(1)
    func removeAll() {
        head = nil
        tail = nil
        count = 0
    }

    /// O(1)
    func popFirst() -> Node? {
        guard let head = head else {
            return nil
        }
        remove(node: head)
        return head
    }

    /// O(n)
    func popLast() -> Node? {
        guard let tail = tail else {
            return nil
        }
        remove(node: tail)
        return tail
    }

    /// O(n)
    func node(at index: Index) -> Node? {
        if isEmpty {
            return nil
        } else if index <= startIndex {
            return head
        } else if index >= endIndex {
            return tail
        }
        for (currentIndex, currentNode) in self.enumerated() where index == currentIndex {
            return currentNode
        }
        return nil
    }

    /// O(n)
    func node(before node: Node) -> Node? {
        if node === head {
            return nil
        }
        for current in self where node === current.next {
            return current
        }
        return nil
    }

    /// O(1)
    func node(after node: Node) -> Node? {
        return node.next
    }
}

extension SinglyLinkedList: Sequence {
    struct Iterator: IteratorProtocol {
        var current: Node?

        init(startingAt node: SinglyLinkedList<Element>.Node?) {
            current = node
        }

        mutating func next() -> Node? {
            current = current?.next
            return current
        }
    }

    func makeIterator() -> SinglyLinkedList<Element>.Iterator {
        return Iterator(startingAt: head)
    }
}

extension SinglyLinkedList: ExpressibleByArrayLiteral {
    convenience init(arrayLiteral elements: Element...) {
        self.init()
    }
}
