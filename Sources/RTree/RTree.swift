import Foundation

public class RTree {
    public var root: Node
    let maxEntries: Int
    let minEntries: Int

    public init(maxEntries: Int = 9) {
        self.maxEntries = max(4, maxEntries)
        self.minEntries = max(2, Int(ceil(Double(maxEntries) * 0.4)))
        self.root = .createNode()
    }

    // MARK: - Retrival
    public func traverse() -> [Node] {
        _traverse(from: root)
    }

    private func _traverse(from _root: Node) -> [Node] {
        var result: [Node] = []
        var nodesToSearch: [Node] = []
        var currentNode: Node? = _root
        while let node = currentNode {
            if node.isLeaf {
                result.append(contentsOf: node.children)
            } else {
                nodesToSearch.append(contentsOf: node.children)
            }
            currentNode = nodesToSearch.popLast()
        }
        return result
    }

    // MARK: - Search
    public func search(box: Box) -> [Node] {
        guard box.intersects(with: root.box) else { return [] }
        var result: [Node] = []
        var nodesToSearch: [Node] = []
        var currentNode: Node? = root
        while let node = currentNode {
            for childNode in node.children {
                if box.intersects(with: childNode.box) {
                    if node.isLeaf {
                        result.append(childNode)
                    } else if box.contains(with: childNode.box) {
                        result.append(contentsOf: _traverse(from: childNode))
                    } else {
                        nodesToSearch.append(childNode)
                    }
                }
            }
            currentNode = nodesToSearch.popLast()
        }
        return result
    }

    // MARK: - Insertion
    public func insert(box: Box) {
        let node: Node = .createNode(in: box)
        _insert(node, level: root.height - 1)
    }

    private func _insert(_ node: Node, level: Int) {
        let box = node.box
        var path: [Node] = []
        var level = level
        let leafNode = _chooseSubtree(for: box, from: root, at: level, into: &path)
        leafNode.children.append(node)
        leafNode.box.enlarge(for: box)
        while level >= 0 {
            guard path[level].children.count > maxEntries else {
                break
            }
            _split(on: path, at: level)
            level -= 1
        }
        _adjustParentBoxes(with: box, through: path, at: level)
    }

    private func _chooseSubtree(for box: Box, from rootNode: Node, at level: Int, into path: inout [Node]) -> Node {
        var node = rootNode
        while true {
            path.append(node)
            if node.isLeaf || path.count - 1 == level { break }
            var minArea: Double = .infinity
            var minEnlargement: Double = .infinity
            var targetNode: Node?
            for node in node.children {
                let area = node.box.area
                let enlargement = box.enlargedArea(for: node.box) - area
                if enlargement < minEnlargement {
                    minEnlargement = enlargement
                    minArea = area < minArea ? area : minArea;
                    targetNode = node
                } else if enlargement == minEnlargement {
                    if area < minArea {
                        minArea = area
                        targetNode = node
                    }
                }
            }
            node = targetNode ?? node.children[0]
        }
        return node
    }

    // MARK: - Splitting
    private func _split(on path: [Node], at level: Int) {
        let node = path[level]
        let numOfChildren = node.children.count
        let minNumOfChildren = minEntries

        _chooseSplitAxis(for: node, with: numOfChildren, by: minNumOfChildren)
        let splitIndex = _chooseSplitIndex(for: node, with: numOfChildren, by: minNumOfChildren)

        let children = Array(node.children[splitIndex..<node.children.count])
        node.children.removeSubrange(splitIndex..<node.children.count)
        let newNode: Node = .createNode(with: children)
        newNode.height = node.height
        newNode.isLeaf = node.isLeaf

        node.updateBox()
        newNode.updateBox()

        if level > 0 {
            path[level - 1].children.append(newNode)
        } else {
            _splitRoot(with: node, and: newNode)
        }
    }

    private func _splitRoot(with node: Node, and newNode: Node) {
        root = .createNode(with: [node, newNode])
        root.height = node.height + 1
        root.isLeaf = false
        root.updateBox()
    }

    private func _chooseSplitAxis(for node: Node, with numOfChildren: Int, by minEntries: Int) {
        let comparatorX: (Node, Node) -> Bool = { $0.box.minX < $1.box.minX }
        let comparatorY: (Node, Node) -> Bool = { $0.box.minY < $1.box.minY }
        let xMargin = _calculateDistributionMargin(for: node, with: numOfChildren, by: minEntries, using: comparatorX)
        let yMargin = _calculateDistributionMargin(for: node, with: numOfChildren, by: minEntries, using: comparatorY)
        if xMargin < yMargin {
            node.children.sort(by: comparatorX)
        }
    }

    private func _calculateDistributionMargin(for node: Node, with numOfChildren: Int, by minEntries: Int, using comparator: (Node, Node) -> Bool) -> Double {
        node.children.sort(by: comparator)
        let leftNode = mergeChildNodes(of: node, from: 0, to: minEntries)
        let rightNode = mergeChildNodes(of: node, from: numOfChildren - minEntries, to: numOfChildren)
        var margin = leftNode.box.margin + rightNode.box.margin

        for index in minEntries..<numOfChildren - minEntries {
            let node = node.children[index]
            leftNode.box.enlarge(for: node.box)
            margin += leftNode.box.margin
        }
        for index in stride(from: numOfChildren - minEntries - 1, through: minEntries, by: -1) {
            let node = node.children[index]
            rightNode.box.enlarge(for: node.box)
            margin += rightNode.box.margin
        }
        return margin
    }

    private func _chooseSplitIndex(for node: Node, with numOfChildren: Int, by minEntries: Int) -> Int {
        var index: Int?
        var minOverlap: Double = .infinity
        var minArea: Double = .infinity
        for idx in minEntries...numOfChildren - minEntries {
            let node1 = mergeChildNodes(of: node, from: 0, to: idx)
            let node2 = mergeChildNodes(of: node, from: idx, to: numOfChildren)

            let overlap = node1.box.intersectedArea(on: node2.box)
            let area = node1.box.area + node2.box.area

            if overlap < minOverlap {
                minOverlap = overlap
                index = idx
                minArea = min(area, minArea)
            } else if overlap == minOverlap {
                if area < minArea {
                    minArea = area
                    index = idx
                }
            }
        }
        return index ?? numOfChildren - minEntries
    }

    private func _adjustParentBoxes(with box: Box, through path: [Node], at level: Int) {
        for index in stride(from: level, through: 0, by: -1) {
            path[index].box.enlarge(for: box)
        }
    }

    public func mergeChildNodes(of node: Node, from start: Int, to end: Int, into newNode: Node = .createNode()) -> Node {
        newNode.box = .infinity
        for index in start..<end {
            let node = node.children[index]
            newNode.box.enlarge(for: node.box)
        }
        return newNode
    }
}
