import RTree
import XCTest

class BaseTestCase: XCTestCase {
    func createRTree(maxEntries: Int) -> RTree {
        let tree = RTree(maxEntries: maxEntries)
        return tree
    }

    func insertBoxes(from start: Int, to end: Int, on tree: RTree) {
        for index in start..<end {
            tree.insert(box: Mock.boxes[index])
        }
    }

    func load(from string: String) -> [Box] {
        guard let data = string.data(using: .utf8) else { return [] }
        guard let boxes = try? JSONDecoder().decode([Box].self, from: data) else { return [] }
        return boxes
    }
}
