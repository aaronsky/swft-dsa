//
//  File.swift
//  
//
//  Created by Aaron Sky on 7/21/19.
//

import XCTest
@testable import DSA

final class LinkedListTests: XCTestCase {

    func testHasCyclesTrue() {
        let list = SinglyLinkedList<Int>()
        list.append(1)
        list.append(2)
        let twoNode = list.tail
        list.append(3)
        list.append(4)
        list.append(5)
        list.append(6)
        list.append(7)
        list.append(8)
        list.append(9)
        list.append(10)
        list.tail?.next = twoNode
        XCTAssertTrue(list.hasCycle)
    }

    func testHasCyclesFalse() {
        let list: SinglyLinkedList<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        XCTAssertFalse(list.hasCycle)
    }
}
