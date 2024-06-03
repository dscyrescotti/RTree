import Foundation

public class Node<T> where T: Equatable {
    public var box: Box
    public var value: T?
    public var isLeaf: Bool
    public var height: Int
    public var children: [Node]

    public init(box: Box, value: T? = nil, isLeaf: Bool, height: Int, children: [Node] = []) {
        self.box = box
        self.value = value
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

    public static func createNode(in box: Box = .infinity, for value: T? = nil, with children: [Node] = []) -> Node {
        Node(box: box, value: value, isLeaf: true, height: 1, children: children)
    }
}
