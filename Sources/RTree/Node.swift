import Foundation

public class Node {
    public var box: Box
    public var isLeaf: Bool
    public var height: Int
    public var children: [Node]

    public init(box: Box, isLeaf: Bool, height: Int, children: [Node] = []) {
        self.box = box
        self.isLeaf = isLeaf
        self.height = height
        self.children = children
    }

    public func updateBox() {
        box = .infinity
        for node in children {
            box.enlarge(for: node.box)
        }
    }

    public static func createNode(in box: Box = .infinity, with children: [Node] = []) -> Node {
        Node(box: box, isLeaf: true, height: 1, children: children)
    }
}
