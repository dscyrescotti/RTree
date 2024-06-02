import XCTest
@testable import RTree

let boxes = [
    [0,0,0,0], [10,10,10,10], [20,20,20,20], [25,0,25,0], [35,10,35,10],
    [45,20,45,20], [0,25,0,25], [10,35,10,35], [20,45,20,45], [25,25,25,25],
    [35,35,35,35], [45,45,45,45], [50,0,50,0], [60,10,60,10], [70,20,70,20],
    [75,0,75,0], [85,10,85,10], [95,20,95,20], [50,25,50,25], [60,35,60,35],
    [70,45,70,45], [75,25,75,25], [85,35,85,35], [95,45,95,45], [0,50,0,50],
    [10,60,10,60], [20,70,20,70], [25,50,25,50], [35,60,35,60], [45,70,45,70],
    [0,75,0,75], [10,85,10,85], [20,95,20,95], [25,75,25,75], [35,85,35,85],
    [45,95,45,95], [50,50,50,50], [60,60,60,60], [70,70,70,70], [75,50,75,50],
    [85,60,85,60], [95,70,95,70], [50,75,50,75], [60,85,60,85], [70,95,70,95],
    [75,75,75,75], [85,85,85,85], [95,95,95,95]
].map { Box(minX: $0[0], minY: $0[1], maxX: $0[2], maxY: $0[3]) }

let result0To5 = """
[
  { "minX": 0, "minY": 0, "maxX": 0, "maxY": 0 },
  { "minX": 10, "minY": 10, "maxX": 10, "maxY": 10 },
  { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 },
  { "minX": 25, "minY": 0, "maxX": 25, "maxY": 0 },
  { "minX": 35, "minY": 10, "maxX": 35, "maxY": 10 }
]
"""
let result0To8 = """
[
  { "minX": 0, "minY": 0, "maxX": 0, "maxY": 0 },
  { "minX": 10, "minY": 10, "maxX": 10, "maxY": 10 },
  { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 },
  { "minX": 25, "minY": 0, "maxX": 25, "maxY": 0 },
  { "minX": 35, "minY": 10, "maxX": 35, "maxY": 10 },
  { "minX": 45, "minY": 20, "maxX": 45, "maxY": 20 },
  { "minX": 0, "minY": 25, "maxX": 0, "maxY": 25 },
  { "minX": 10, "minY": 35, "maxX": 10, "maxY": 35 }
]
"""
let result0To10 = """
[
  { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 },
  { "minX": 45, "minY": 20, "maxX": 45, "maxY": 20 },
  { "minX": 0, "minY": 25, "maxX": 0, "maxY": 25 },
  { "minX": 10, "minY": 35, "maxX": 10, "maxY": 35 },
  { "minX": 20, "minY": 45, "maxX": 20, "maxY": 45 },
  { "minX": 25, "minY": 25, "maxX": 25, "maxY": 25 },
  { "minX": 0, "minY": 0, "maxX": 0, "maxY": 0 },
  { "minX": 25, "minY": 0, "maxX": 25, "maxY": 0 },
  { "minX": 10, "minY": 10, "maxX": 10, "maxY": 10 },
  { "minX": 35, "minY": 10, "maxX": 35, "maxY": 10 }
]
"""
let result0To20 = """
[
  { "minX": 35, "minY": 35, "maxX": 35, "maxY": 35 },
  { "minX": 45, "minY": 20, "maxX": 45, "maxY": 20 },
  { "minX": 45, "minY": 45, "maxX": 45, "maxY": 45 },
  { "minX": 70, "minY": 20, "maxX": 70, "maxY": 20 },
  { "minX": 95, "minY": 20, "maxX": 95, "maxY": 20 },
  { "minX": 50, "minY": 25, "maxX": 50, "maxY": 25 },
  { "minX": 60, "minY": 35, "maxX": 60, "maxY": 35 },
  { "minX": 0, "minY": 25, "maxX": 0, "maxY": 25 },
  { "minX": 10, "minY": 35, "maxX": 10, "maxY": 35 },
  { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 },
  { "minX": 20, "minY": 45, "maxX": 20, "maxY": 45 },
  { "minX": 25, "minY": 25, "maxX": 25, "maxY": 25 },
  { "minX": 0, "minY": 0, "maxX": 0, "maxY": 0 },
  { "minX": 25, "minY": 0, "maxX": 25, "maxY": 0 },
  { "minX": 10, "minY": 10, "maxX": 10, "maxY": 10 },
  { "minX": 35, "minY": 10, "maxX": 35, "maxY": 10 },
  { "minX": 50, "minY": 0, "maxX": 50, "maxY": 0 },
  { "minX": 60, "minY": 10, "maxX": 60, "maxY": 10 },
  { "minX": 75, "minY": 0, "maxX": 75, "maxY": 0 },
  { "minX": 85, "minY": 10, "maxX": 85, "maxY": 10 }
]
"""
let result0To48 = """
[
  { "minX": 35, "minY": 85, "maxX": 35, "maxY": 85 },
  { "minX": 60, "minY": 85, "maxX": 60, "maxY": 85 },
  { "minX": 45, "minY": 95, "maxX": 45, "maxY": 95 },
  { "minX": 70, "minY": 95, "maxX": 70, "maxY": 95 },
  { "minX": 85, "minY": 85, "maxX": 85, "maxY": 85 },
  { "minX": 95, "minY": 95, "maxX": 95, "maxY": 95 },
  { "minX": 20, "minY": 70, "maxX": 20, "maxY": 70 },
  { "minX": 0, "minY": 75, "maxX": 0, "maxY": 75 },
  { "minX": 25, "minY": 75, "maxX": 25, "maxY": 75 },
  { "minX": 10, "minY": 85, "maxX": 10, "maxY": 85 },
  { "minX": 20, "minY": 95, "maxX": 20, "maxY": 95 },
  { "minX": 35, "minY": 60, "maxX": 35, "maxY": 60 },
  { "minX": 60, "minY": 60, "maxX": 60, "maxY": 60 },
  { "minX": 45, "minY": 70, "maxX": 45, "maxY": 70 },
  { "minX": 70, "minY": 70, "maxX": 70, "maxY": 70 },
  { "minX": 50, "minY": 75, "maxX": 50, "maxY": 75 },
  { "minX": 75, "minY": 75, "maxX": 75, "maxY": 75 },
  { "minX": 70, "minY": 45, "maxX": 70, "maxY": 45 },
  { "minX": 95, "minY": 45, "maxX": 95, "maxY": 45 },
  { "minX": 75, "minY": 50, "maxX": 75, "maxY": 50 },
  { "minX": 85, "minY": 60, "maxX": 85, "maxY": 60 },
  { "minX": 95, "minY": 70, "maxX": 95, "maxY": 70 },
  { "minX": 20, "minY": 45, "maxX": 20, "maxY": 45 },
  { "minX": 0, "minY": 50, "maxX": 0, "maxY": 50 },
  { "minX": 25, "minY": 50, "maxX": 25, "maxY": 50 },
  { "minX": 10, "minY": 60, "maxX": 10, "maxY": 60 },
  { "minX": 70, "minY": 20, "maxX": 70, "maxY": 20 },
  { "minX": 95, "minY": 20, "maxX": 95, "maxY": 20 },
  { "minX": 75, "minY": 25, "maxX": 75, "maxY": 25 },
  { "minX": 60, "minY": 35, "maxX": 60, "maxY": 35 },
  { "minX": 85, "minY": 35, "maxX": 85, "maxY": 35 },
  { "minX": 45, "minY": 20, "maxX": 45, "maxY": 20 },
  { "minX": 50, "minY": 25, "maxX": 50, "maxY": 25 },
  { "minX": 35, "minY": 35, "maxX": 35, "maxY": 35 },
  { "minX": 45, "minY": 45, "maxX": 45, "maxY": 45 },
  { "minX": 50, "minY": 50, "maxX": 50, "maxY": 50 },
  { "minX": 20, "minY": 20, "maxX": 20, "maxY": 20 },
  { "minX": 0, "minY": 25, "maxX": 0, "maxY": 25 },
  { "minX": 25, "minY": 25, "maxX": 25, "maxY": 25 },
  { "minX": 10, "minY": 35, "maxX": 10, "maxY": 35 },
  { "minX": 0, "minY": 0, "maxX": 0, "maxY": 0 },
  { "minX": 25, "minY": 0, "maxX": 25, "maxY": 0 },
  { "minX": 10, "minY": 10, "maxX": 10, "maxY": 10 },
  { "minX": 35, "minY": 10, "maxX": 35, "maxY": 10 },
  { "minX": 50, "minY": 0, "maxX": 50, "maxY": 0 },
  { "minX": 60, "minY": 10, "maxX": 60, "maxY": 10 },
  { "minX": 75, "minY": 0, "maxX": 75, "maxY": 0 },
  { "minX": 85, "minY": 10, "maxX": 85, "maxY": 10 }
]
"""

final class RTreeInsertionTests: XCTestCase {
    func testInsertion0To5() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 5, on: tree)
        let result = tree.traverse().map { $0.box }
        let expectation = load(from: result0To5)
        XCTAssertEqual(result, expectation)
    }

    func testInsertion0To8() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 8, on: tree)
        let result = tree.traverse().map { $0.box }
        let expectation = load(from: result0To8)
        XCTAssertEqual(result, expectation)
    }

    func testInsertion0To10() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 10, on: tree)
        let result = tree.traverse().map { $0.box }
        let expectation = load(from: result0To10)
        XCTAssertEqual(result, expectation)
    }

    func testInsertion0To20() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 20, on: tree)
        let result = tree.traverse().map { $0.box }
        let expectation = load(from: result0To20)
        XCTAssertEqual(result, expectation)
    }

    func testInsertion0To48() {
        let tree = createRTree(maxEntries: 8)
        insertBoxes(from: 0, to: 48, on: tree)
        let result = tree.traverse().map { $0.box }
        let expectation = load(from: result0To48)
        XCTAssertEqual(result, expectation)
    }

    private func createRTree(maxEntries: Int) -> RTree {
        let tree = RTree(maxEntries: maxEntries)
        return tree
    }

    private func insertBoxes(from start: Int, to end: Int, on tree: RTree) {
        for index in start..<end {
            tree.insert(box: boxes[index])
        }
    }

    private func load(from string: String) -> [Box] {
        guard let data = string.data(using: .utf8) else { return [] }
        guard let boxes = try? JSONDecoder().decode([Box].self, from: data) else { return [] }
        return boxes
    }
}
