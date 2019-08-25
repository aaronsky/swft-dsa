//
//  BouncingBall.swift
//
//  Created by Aaron Sky on 8/24/19.
//

public enum Fibonacci {
    static func fibonacci(_ num: Int) -> Int {
        guard num >= 2 else {
            return num
        }
        
        var n1 = 1
        var n2 = 0
        
        for _ in 2..<num {
            let n0 = n1 + n2
            n2 = n1
            n1 = n0
        }
        
        return n1 + n2
    }
}

public struct Coins {
    let coins: [Int]
    
    init(delineations coins: [Int]) {
        self.coins = coins
    }
    
    func numberOfCoins(for change: Int) -> Int {
        var cache = [Int](repeating: 0, count: change + 1)
        for i in 1...change {
            var minCoins = Int.max
            
            for coin in coins where i - coin >= 0 {
                let currCoins = cache[i - coin] + 1
                if currCoins < minCoins {
                    minCoins = currCoins
                }
            }
            cache[i] = minCoins
        }
        return cache[change]
    }
}

public struct SquareSubMatrix {
    let matrix: [[Bool]]
    
    init(matrix: [[Bool]]) {
        self.matrix = matrix
    }
    
    func findLargest() -> Int {
        var cache = [[Int]](repeating: [Int](repeating: 0, count: matrix[0].count), count: matrix.count)
        var maxSize = 0
        for i in 0..<cache.count {
            for j in 0..<cache[i].count {
                if i == cache.startIndex || j == cache[i].startIndex {
                    cache[i][j] = matrix[i][j] ? 1 : 0
                } else if matrix[i][j] {
                    cache[i][j] = 1 + min(
                        cache[i][j - 1],
                        cache[i - 1][j],
                        cache[i - 1][j - 1]
                    )
                }
                if cache[i][j] > maxSize {
                    maxSize = cache[i][j]
                }
            }
        }
        return maxSize
    }
}

public struct Knapsack {
    public struct Item {
        let weight: Int
        let value: Int
    }
    
    let capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func maximumPossibleValue(from items: [Item]) -> Int {
        var itemCache = [Int](repeating: 0, count: capacity + 1)
        
        for item in items {
            var newItemCache = [Int](repeating: 0, count: capacity + 1)
            
            for j in 0...capacity {
                if item.weight > j {
                    newItemCache[j] = itemCache[j]
                } else {
                    newItemCache[j] = max(itemCache[j], itemCache[j - item.weight] + item.value)
                }
            }
            
            itemCache = newItemCache
        }
        
        return itemCache[capacity]
    }
}

public enum TargetSum {
    static func numberOfPossibleSums(targeting target: Int, in numbers: [Int]) -> Int {
        let sum = numbers.reduce(0, +)
        let sumDimension = 2 * sum + 1
        var cache = [[Int]](repeating: [Int](repeating: 0, count: sumDimension), count: numbers.count + 1)
        
        guard sum != 0 else {
            return 0
        }

        cache[0][sum] = 1
        
        for i in 1...numbers.count {
            for j in 0..<sumDimension {
                let prev = cache[i - 1][j]
                if prev != 0 {
                    cache[i][j - numbers[i - 1]] += prev
                    cache[i][j + numbers[i - 1]] += prev
                }
            }
        }
        
        return cache[numbers.count][sum + target]
    }
}
