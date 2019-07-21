//
//  Heap.swift
//  
//
//  Created by Aaron Sky on 7/19/19.
//

// In a max heap, parent nodes must always contain a value that is greater than or
// equal to the value in its children. The root node will always contain the highest value.
//
// In a min heap, parent nodes must always contain a value that is less than or equal
// to the value in its children. The root node will always contain the lowest value.

struct Heap<Element: Equatable> {
    typealias Index = Int

    var elements: [Element] = []
    let areInIncreasingOrder: (Element, Element) -> Bool

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    init(sortedBy areInIncreasingOrder: @escaping (Element, Element) -> Bool, contentsOf elements: [Element] = []) {
        self.areInIncreasingOrder = areInIncreasingOrder
        self.elements = elements
        buildHeap()
    }

    /// O(n log n)
    private mutating func buildHeap() {
        guard !elements.isEmpty else {
            return
        }
        let from = (count / 2) - 1
        for i in stride(from: from, through: 0, by: -1) {
            siftDown(from: i)
        }
    }

    /// O(log n)
    mutating func push(_ element: Element) {
        elements.append(element)
        siftUp(from: count - 1)
    }

    /// O(1)
    func peek() -> Element? {
        return elements.first
    }

    /// O(log n)
    @discardableResult
    mutating func pop() -> Element? {
        guard !isEmpty else {
            return nil
        }

        elements.swapAt(0, count - 1)

        let poppedElement = elements.removeLast()
        siftDown(from: 0)

        return poppedElement
    }

    /// O(log n)
    @discardableResult
    mutating func removeElement(at index: Index) -> Element? {
        /*
         Check to see if the index is within the bounds of the array. If not, return nil.
         If you’re removing the last element in the heap, you don’t need to do anything special. Simply remove and return the element.
         If you’re not removing the last element, first swap the element with the last element.
         Then, return and remove the last element.
         Finally, perform a sift down and a sift up to adjust the heap.
         */
        guard elements.contains(index: index) else {
            return nil
        }
        if index == elements.endIndex - 1 {
            return pop()
        }
        elements.swapAt(index, elements.endIndex - 1)
        let poppedElement = pop()
        siftDown(from: index)
        siftUp(from: index)
        return poppedElement
    }

    /// O(1)
    func index(leftOf parent: Index) -> Index {
        return (parent * 2) + 1
    }

    /// O(1)
    func index(rightOf parent: Index) -> Index {
        return (parent * 2) + 2
    }

    /// O(1)
    func index(ofParent child: Index) -> Index {
        return (child - 1) / 2
    }

    /// O(n)
    func firstIndex(startingAt index: Index, where predicate: (Element) throws -> Bool) rethrows -> Index? {
        guard elements.contains(index: index) else {
            return nil
        }

//        if sort(element, elements[i]) {
//            return nil // 2
//          }

        if try predicate(elements[index]) {
            return index
        } else if let leftIndex = try firstIndex(startingAt: self.index(leftOf: index), where: predicate) {
            return leftIndex
        } else if let rightIndex = try firstIndex(startingAt: self.index(rightOf: index), where: predicate) {
            return rightIndex
        }

        return nil
    }

    /// O(log n)
    mutating func siftUp(from index: Index) {
        var child = index
        var parent = self.index(ofParent: child)

        while child > 0 && areInIncreasingOrder(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = self.index(ofParent: child)
        }
    }

    /// O(log n)
    mutating func siftDown(from index: Index) {
        var parent = index

        while true {
            let left = self.index(leftOf: parent)
            let right = self.index(rightOf: parent)

            var candidate = parent

            if left < count && areInIncreasingOrder(elements[left], elements[candidate]) {
                candidate = left
            }

            if right < count && areInIncreasingOrder(elements[right], elements[candidate]) {
                candidate = right
            }

            if candidate == parent {
                return
            }

            elements.swapAt(candidate, parent)
            parent = candidate
        }
    }

    static func + (_ lhs: Heap<Element>, _ rhs: Heap<Element>) -> Heap<Element> {
        return .init(sortedBy: lhs.areInIncreasingOrder, contentsOf: lhs.elements + rhs.elements)
    }
}
