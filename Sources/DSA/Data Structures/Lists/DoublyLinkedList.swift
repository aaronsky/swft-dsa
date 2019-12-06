import Foundation

final class DoublyLinkedList<Element> {
    typealias Index = Int

    class Node {
        var value: Element
        var next: Node?
        weak var previous: Node?

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

    required init() {

    }

    /// O(1)
    func prepend(_ element: Element) {
        let newNode = Node(element)
        if isEmpty {
            self.head = newNode
            self.tail = newNode
            count += 1
            return
        }
        guard let head = head else {
            return
        }
        insert(node: newNode, before: head)
        self.head = newNode
    }

    /// O(1)
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

    /// O(1)
    func insert(node: Node, before right: Node) {
        let left = right.previous
        left?.next = node
        right.previous = node
        node.previous = left
        node.next = right
        count += 1
    }

    /// O(1)
    func insert(node: Node, after left: Node) {
        let right = left.next
        right?.previous = node
        left.next = node
        node.previous = left
        node.next = right
        count += 1
    }

    /// O(1)
    func remove(node: Node) {
        if node === head {
            let rightNode = node.next
            rightNode?.previous = nil
            head = rightNode
        } else if node === tail {
            let leftNode = node.previous
            leftNode?.next = nil
            tail = leftNode
        } else {
            let leftNode = node.previous
            let rightNode = node.next
            leftNode?.next = rightNode
            rightNode?.previous = leftNode
        }
        node.previous = nil
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
        guard let node = head else {
            return nil
        }
        remove(node: node)
        return node
    }

    /// O(1)
    func popLast() -> Node? {
        guard let node = tail else {
            return nil
        }
        remove(node: node)
        return node
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
}

extension DoublyLinkedList: Sequence {
    struct Iterator: IteratorProtocol {
        var current: Node?

        init(startingAt node: DoublyLinkedList<Element>.Node?) {
            current = node
        }

        mutating func next() -> Node? {
            current = current?.next
            return current
        }
    }

    func makeIterator() -> DoublyLinkedList<Element>.Iterator {
        return Iterator(startingAt: head)
    }
}

extension DoublyLinkedList: ExpressibleByArrayLiteral {
    convenience init(arrayLiteral elements: Element...) {
        self.init()
        for element in elements {
            append(element)
        }
    }
}
