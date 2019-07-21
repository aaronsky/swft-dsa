public struct BubbleSortAlgorithm: SortAlgorithm {
    public func sort<T: Equatable>(_ array: inout [T], by areInIncreasingOrder: @escaping (T, T) throws -> Bool) rethrows {
        for i in 0..<array.count {
            for j in 1..<array.count - i {
                if try areInIncreasingOrder(array[j], array[j - 1]) {
                    let temp = array[j - 1]
                    array[j - 1] = array[j]
                    array[j] = temp
                }
            }
        }
    }
}
