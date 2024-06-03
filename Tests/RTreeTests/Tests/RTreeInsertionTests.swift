import XCTest
@testable import RTree

final class RTreeInsertionTests: BaseTestCase {
    let result0To5 = """
    [ 0, 1, 2, 3, 4 ]
    """
    let result0To8 = """
    [
      0, 1, 2, 3,
      4, 5, 6, 7
    ]
    """
    let result0To10 = """
    [
      2, 5, 6, 7, 8,
      9, 0, 3, 1, 4
    ]
    """
    let result0To20 = """
    [
      10, 5, 11, 14, 17, 18, 19,
       6, 7,  2,  8,  9,  0,  3,
       1, 4, 12, 13, 15, 16
    ]
    """
    let result0To48 = """
    [
      34, 43, 35, 44, 46, 47, 26, 30, 33, 31, 32,
      28, 37, 29, 38, 42, 45, 20, 23, 39, 40, 41,
       8, 24, 27, 25, 14, 17, 21, 19, 22,  5, 18,
      10, 11, 36,  2,  6,  9,  7,  0,  3,  1,  4,
      12, 13, 15, 16
    ]
    """
    
    func testInsertion0To5() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 5, on: tree)
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To5)
        XCTAssertEqual(result, expectation)
    }

    func testInsertion0To8() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 8, on: tree)
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To8)
        XCTAssertEqual(result, expectation)
    }

    func testInsertion0To10() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 10, on: tree)
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To10)
        XCTAssertEqual(result, expectation)
    }

    func testInsertion0To20() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 20, on: tree)
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To20)
        XCTAssertEqual(result, expectation)
    }

    func testInsertion0To48() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 48, on: tree)
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To48)
        XCTAssertEqual(result, expectation)
    }
}
