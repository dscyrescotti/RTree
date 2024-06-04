import XCTest
@testable import RTree

final class RTreeRemovalTests: BaseTestCase {
    let result0To5 = """
    [ 1, 2, 3 ]
    """
    let result0To8 = """
    [ 0, 2, 4, 6, 7 ]
    """
    let result0To10 = """
    [ 6, 8, 0, 1, 4 ]
    """
    let result0To20 = """
    [
      10, 11, 14, 17,  6,
       8,  0,  1,  4, 12,
      15, 16
    ]
    """
    let result0To48 = """
    [
      34, 43, 35, 44, 46, 47, 26, 30, 33,
      31, 29, 38, 42, 45, 23, 39, 41,  8,
      24, 27, 25, 14, 17, 21, 22, 10, 11,
      36,  6,  0,  1,  4, 12, 15, 16
    ]
    """

    func testRemoval0To5() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 5, on: tree)
        tree.remove(0, in: Box(minX: 0, minY: 0, maxX: 0, maxY: 0))
        tree.remove(4, in: Box(minX: 35, minY: 10, maxX: 35, maxY: 10))
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To5)
        XCTAssertEqual(result, expectation)
    }

    func testRemoval0To8() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 8, on: tree)
        for value in [5, 1, 3] {
            tree.remove(value, in: Mock.boxes[value])
        }
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To8)
        XCTAssertEqual(result, expectation)
    }

    func testRemoval0To10() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 10, on: tree)
        for value in [5, 9, 2, 3, 7] {
            tree.remove(value, in: Mock.boxes[value])
        }
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To10)
        XCTAssertEqual(result, expectation)
    }

    func testRemoval0To20() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 20, on: tree)
        let indices = [5, 18, 9, 2, 13, 3, 19, 7]
        for value in indices {
            tree.remove(value, in: Mock.boxes[value])
        }
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To20)
        XCTAssertEqual(result, expectation)
    }

    func testRemoval0To48() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 48, on: tree)
        let indices = [5, 18, 9, 2, 13, 3, 19, 7, 40, 20, 32, 32, 13, 37, 28]
        for value in indices {
            tree.remove(value, in: Mock.boxes[value])
        }
        let result = tree.traverse()
        let expectation = load(Int.self, from: result0To48)
        XCTAssertEqual(result, expectation)
    }
}
