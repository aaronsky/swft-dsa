//
//  LRUCacheTests.swift
//  
//
//  Created by Aaron Sky on 8/25/19.
//

import XCTest
@testable import DSA

final class LRUCacheTests: XCTestCase {

    func testCacheRespectsCapacity() {
        let cache = LRUCache<String, Int>(capacity: 5)
        XCTAssertEqual(cache.count, 0)
        cache["andre"] = 8
        cache["steve"] = 1
        cache["ash"] = 5
        cache["derek"] = 7
        cache["jon"] = 1
        XCTAssertEqual(cache.count, 5)
        cache["tom"] = 8
        XCTAssertEqual(cache.count, 5)
        XCTAssertNil(cache["andre"])
        XCTAssertNotNil(cache["steve"])
        cache["ash"] = 6
        XCTAssertEqual(cache["ash"], 6)
        XCTAssertNil(cache["roxie"])
    }
}
