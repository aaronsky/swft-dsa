//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/20/19.
//

public struct QuickSortAlgorithm: SortAlgorithm {
    public func sort<T: Equatable>(_ array: inout [T], by areInIncreasingOrder: @escaping  (T, T) throws -> Bool) rethrows {
        try quicksortDutchFlag(&array, from: 0, to: array.endIndex - 1, by: areInIncreasingOrder)
    }

    private func quicksortDutchFlag<T: Equatable>(_ array: inout [T], from lowIndex: Array<T>.Index, to highIndex: Array<T>.Index, by areInIncreasingOrder: @escaping  (T, T) throws -> Bool) rethrows {
        if lowIndex < highIndex {
            let (middleFirstIndex, middleLastIndex) = try partitionDutchFlag(&array[lowIndex...highIndex], pivoting: highIndex, by: areInIncreasingOrder)
            try quicksortDutchFlag(&array, from: lowIndex, to: middleFirstIndex - 1, by: areInIncreasingOrder)
            try quicksortDutchFlag(&array, from: middleLastIndex + 1, to: highIndex, by: areInIncreasingOrder)
        }
    }

    private func partitionDutchFlag<T: Equatable>(_ slice: inout ArraySlice<T>, pivoting pivotIndex: ArraySlice<T>.Index, by areInIncreasingOrder: @escaping  (T, T) throws -> Bool) rethrows -> (ArraySlice<T>.Index, ArraySlice<T>.Index) {
        let pivot = slice[pivotIndex]
        var smaller = slice.startIndex
        var equal = slice.startIndex
        var larger = slice.endIndex - 1
        while equal <= larger {
            if try areInIncreasingOrder(slice[equal], pivot) {
                slice.swapAt(smaller, equal)
                smaller += 1
                equal += 1
            } else if slice[equal] == pivot {
                equal += 1
            } else {
                slice.swapAt(equal, larger)
                larger -= 1
            }
        }
        return (smaller, larger)
    }
}
