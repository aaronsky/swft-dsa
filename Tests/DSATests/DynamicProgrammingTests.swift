import XCTest
@testable import DSA

final class DynamicProgrammingTests: XCTestCase {
    func testFibonacci() {
        XCTAssertEqual(Fibonacci.fibonacci(15), 610)
    }

    func testCoins() {
        let coins = Coins(delineations: [1, 5, 10, 25])
        XCTAssertEqual(coins.numberOfCoins(for: 1), 1)
        XCTAssertEqual(coins.numberOfCoins(for: 6), 2)
        XCTAssertEqual(coins.numberOfCoins(for: 49), 7)
    }
    
    func testSquareMatrices() {
        let matrix1 = SquareSubMatrix(matrix:
            [
                [false, true, false, false],
                [true, true, true, true],
                [false, true, true, false],
            ]
        )
        XCTAssertEqual(matrix1.findLargest(), 2)
        let matrix2 = SquareSubMatrix(matrix:
            [
                [true, true, true, true, true],
                [true, true, true, true, false],
                [true, true, true, true, false],
                [true, true, true, true, false],
                [true, false, false, false, false],
            ]
        )
        XCTAssertEqual(matrix2.findLargest(), 4)
        let matrix3 = SquareSubMatrix(matrix:
            [
                [true, true, true, true, false],
                [true, true, true, true, false],
                [true, true, true, true, false],
                [false, true, true, true, false],
                [true, false, false, false, false],
            ]
        )
        XCTAssertEqual(matrix3.findLargest(), 3)
    }
    
    func testKnapsack() {
        let knapsack = Knapsack(capacity: 5)
        XCTAssertEqual(knapsack.maximumPossibleValue(from: [
            .init(weight: 2, value: 6),
            .init(weight: 2, value: 10),
            .init(weight: 3, value: 12)
        ]), 22)
    }
    
    func testTargetSum() {
        XCTAssertEqual(
            TargetSum.numberOfPossibleSums(targeting: 3, in: [1, 1, 1, 1, 1]),
            5)
    }
}

