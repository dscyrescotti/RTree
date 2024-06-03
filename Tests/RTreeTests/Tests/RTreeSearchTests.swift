import XCTest
@testable import RTree

class RTreeSearchTests: BaseTestCase {
    let resultBox1 = """
    [ 1, 2 ]
    """
    let resultBox2 = """
    [ 2 ]
    """
    let resultBox3 = """
    [ 2, 5, 7, 8, 9 ]
    """
    let resultBox4 = """
    [
      10, 5, 11, 14, 18,
      19, 7,  2,  8,  9
    ]
    """
    let resultBox5 = """
    [ 5, 18, 2, 9 ]
    """

    func testSearchBox1() {
        let box = Box(minX: 0, minY: 10, maxX: 20, maxY: 25)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 5, on: tree)
        let result = tree.search(box: box)
        let expectation = load(Int.self, from: resultBox1)
        XCTAssertEqual(result, expectation)
    }

    func testSearchBox2() {
        let box = Box(minX: 20, minY: 20, maxX: 40, maxY: 50)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 8, on: tree)
        let result = tree.search(box: box)
        let expectation = load(Int.self, from: resultBox2)
        XCTAssertEqual(result, expectation)
    }

    func testSearchBox3() {
        let box = Box(minX: 5, minY: 20, maxX: 100, maxY: 50)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 10, on: tree)
        let result = tree.search(box: box)
        let expectation = load(Int.self, from: resultBox3)
        XCTAssertEqual(result, expectation)
    }

    func testSearchBox4() {
        let box = Box(minX: 5, minY: 20, maxX: 75, maxY: 70)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 20, on: tree)
        let result = tree.search(box: box)
        let expectation = load(Int.self, from: resultBox4)
        XCTAssertEqual(result, expectation)
    }

    func testSearchBox5() {
        let box = Box(minX: 5, minY: 20, maxX: 55, maxY: 30)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 48, on: tree)
        let result = tree.search(box: box)
        let expectation = load(Int.self, from: resultBox5)
        XCTAssertEqual(result, expectation)
    }
}

