import XCTest
@testable import RTree

class RTreeSearchTests: BaseTestCase {
    let resultBox1 = """
    [
      { "minX": 10, "minY": 10, "maxX": 10, "maxY": 10 },
      { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 }
    ]
    """
    let resultBox2 = """
    [ { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 } ]
    """
    let resultBox3 = """
    [
      { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 },
      { "minX": 45, "minY": 20, "maxX": 45, "maxY": 20 },
      { "minX": 10, "minY": 35, "maxX": 10, "maxY": 35 },
      { "minX": 20, "minY": 45, "maxX": 20, "maxY": 45 },
      { "minX": 25, "minY": 25, "maxX": 25, "maxY": 25 }
    ]
    """
    let resultBox4 = """
    [
      { "minX": 35, "minY": 35, "maxX": 35, "maxY": 35 },
      { "minX": 45, "minY": 20, "maxX": 45, "maxY": 20 },
      { "minX": 45, "minY": 45, "maxX": 45, "maxY": 45 },
      { "minX": 70, "minY": 20, "maxX": 70, "maxY": 20 },
      { "minX": 50, "minY": 25, "maxX": 50, "maxY": 25 },
      { "minX": 60, "minY": 35, "maxX": 60, "maxY": 35 },
      { "minX": 10, "minY": 35, "maxX": 10, "maxY": 35 },
      { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 },
      { "minX": 20, "minY": 45, "maxX": 20, "maxY": 45 },
      { "minX": 25, "minY": 25, "maxX": 25, "maxY": 25 }
    ]
    """
    let resultBox5 = """
    [
      { "minX": 45, "minY": 20, "maxX": 45, "maxY": 20 },
      { "minX": 50, "minY": 25, "maxX": 50, "maxY": 25 },
      { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 },
      { "minX": 25, "minY": 25, "maxX": 25, "maxY": 25 }
    ]
    """

    func testSearchBox1() {
        let box = Box(minX: 0, minY: 10, maxX: 20, maxY: 25)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 5, on: tree)
        let result = tree.search(box: box).map { $0.box }
        let expectation = load(from: resultBox1)
        XCTAssertEqual(result, expectation)
    }

    func testSearchBox2() {
        let box = Box(minX: 20, minY: 20, maxX: 40, maxY: 50)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 8, on: tree)
        let result = tree.search(box: box).map { $0.box }
        let expectation = load(from: resultBox2)
        XCTAssertEqual(result, expectation)
    }

    func testSearchBox3() {
        let box = Box(minX: 5, minY: 20, maxX: 100, maxY: 50)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 10, on: tree)
        let result = tree.search(box: box).map { $0.box }
        let expectation = load(from: resultBox3)
        XCTAssertEqual(result, expectation)
    }

    func testSearchBox4() {
        let box = Box(minX: 5, minY: 20, maxX: 75, maxY: 70)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 20, on: tree)
        let result = tree.search(box: box).map { $0.box }
        let expectation = load(from: resultBox4)
        XCTAssertEqual(result, expectation)
    }

    func testSearchBox5() {
        let box = Box(minX: 5, minY: 20, maxX: 55, maxY: 30)
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 48, on: tree)
        let result = tree.search(box: box).map { $0.box }
        let expectation = load(from: resultBox5)
        XCTAssertEqual(result, expectation)
    }
}

