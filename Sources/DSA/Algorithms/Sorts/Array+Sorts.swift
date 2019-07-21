public protocol SortAlgorithm {
    func sorted<T: Equatable>(_ array: [T], by areInIncreasingOrder: @escaping (T, T) throws -> Bool) rethrows -> [T]
    func sort<T: Equatable>(_ array: inout [T], by areInIncreasingOrder: @escaping (T, T) throws -> Bool) rethrows
}

public extension SortAlgorithm {
    func sorted<T: Equatable>(_ array: [T], by areInIncreasingOrder: @escaping (T, T) throws -> Bool) rethrows -> [T] {
        var newArray = Array(array)
        try sort(&newArray, by: areInIncreasingOrder)
        return newArray
    }
}

public struct SortAlgorithms {
    public static let bubbleSort = BubbleSortAlgorithm()
    public static let mergeSort = MergeSortAlgorithm()
    public static let quickSort = QuickSortAlgorithm()
}

extension Array where Element: Comparable {
    public func sorted(using algorithm: SortAlgorithm) -> [Element] {
        return sorted(using: algorithm, by: <)
    }

    public func sorted(using algorithm: SortAlgorithm, by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool) rethrows -> [Element] {
        return try algorithm.sorted(self, by: areInIncreasingOrder)
    }

    public mutating func sort(using algorithm: SortAlgorithm) {
        sort(using: algorithm, by: <)
    }

    public mutating func sort(using algorithm: SortAlgorithm, by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool) rethrows {
        try algorithm.sort(&self, by: areInIncreasingOrder)
    }
}

extension Array {
    var middleIndex: Index {
        if isEmpty {
            return startIndex
        }
        return count / 2
    }
}
