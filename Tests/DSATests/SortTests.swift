import XCTest
@testable import DSA

final class SortTests: XCTestCase {

    func testBubbleSort() {
        let array = [12, 4, 3, 17, 8, 4, 20, 95, 1]
        XCTAssertEqual(array.sorted(using: SortAlgorithms.bubbleSort), [1, 3, 4, 4, 8, 12, 17, 20, 95])
    }
    
    func testMergeSort() {
        let array = [12, 4, 3, 17, 8, 4, 20, 95, 1]
        XCTAssertEqual(array.sorted(using: SortAlgorithms.mergeSort), [1, 3, 4, 4, 8, 12, 17, 20, 95])
    }
    
    func testQuickSort() {
        let array = [12, 4, 3, 17, 8, 4, 20, 95, 1]
        XCTAssertEqual(array.sorted(using: SortAlgorithms.quickSort), [1, 3, 4, 4, 8, 12, 17, 20, 95])
    }
}
