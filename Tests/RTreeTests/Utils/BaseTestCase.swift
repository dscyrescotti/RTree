import RTree
import XCTest

class BaseTestCase: XCTestCase {
    func createRTree(maxEntries: Int) -> RTree<Int> {
        let tree = RTree<Int>(maxEntries: maxEntries)
        return tree
    }

    func insertBoxes(from start: Int, to end: Int, on tree: RTree<Int>) {
        for index in start..<end {
            tree.insert(index, in: Mock.boxes[index])
        }
    }

    func load<T: Decodable>(_ type: T.Type, from string: String) -> [T] {
        guard let data = string.data(using: .utf8) else { return [] }
        guard let values = try? JSONDecoder().decode([T].self, from: data) else { return [] }
        return values
    }
}
