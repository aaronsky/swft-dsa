import XCTest
@testable import DSA

final class HeapTests: XCTestCase {

    func testChallenge1() {
        let heap = Heap(sortedBy: <, contentsOf: [3, 10, 18, 5, 21, 100])
        XCTAssertEqual(heap.peek(), 3)
    }

    func testChallenge3() {
        let heap1 = Heap(sortedBy: <, contentsOf: [21, 10, 18, 5, 3, 100, 1])
        let heap2 = Heap(sortedBy: <, contentsOf: [21, 10, 18, 5, 3, 100, 1])
        let final = heap1 + heap2
        print(final)
    }
}
