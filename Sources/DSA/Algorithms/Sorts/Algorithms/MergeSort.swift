public struct MergeSortAlgorithm: SortAlgorithm {
    public func sort<T: Equatable>(_ array: inout [T], by areInIncreasingOrder: @escaping  (T, T) throws -> Bool) rethrows {
        guard array.count > 1 else {
            return
        }
        let left = try sorted(Array(array[0..<array.middleIndex]), by: areInIncreasingOrder)
        let right = try sorted(Array(array[array.middleIndex..<array.count]), by: areInIncreasingOrder)
        array = try merge(left, right, by: areInIncreasingOrder)
    }

    private func merge<T>(_ left: [T], _ right: [T], by areInIncreasingOrder: (T, T) throws -> Bool) rethrows -> [T] {
        var leftIndex = left.startIndex
        var rightIndex = right.startIndex

        var pile = [T]()
        pile.reserveCapacity(left.count + right.count)

        while leftIndex < left.count && rightIndex < right.count {
            if try areInIncreasingOrder(left[leftIndex], right[rightIndex]) {
                pile.append(left[leftIndex])
                leftIndex += 1
            } else {
                pile.append(right[rightIndex])
                rightIndex += 1
            }
        }

        while leftIndex < left.count {
            pile.append(left[leftIndex])
            leftIndex += 1
        }

        while rightIndex < right.count {
            pile.append(right[rightIndex])
            rightIndex += 1
        }

        return pile
    }
}
