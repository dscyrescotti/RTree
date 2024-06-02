import Foundation

public struct Box: Equatable, Decodable {
    public var minX: Double
    public var minY: Double
    public var maxX: Double
    public var maxY: Double

    public init(minX: Double, minY: Double, maxX: Double, maxY: Double) {
        self.minX = minX
        self.minY = minY
        self.maxX = maxX
        self.maxY = maxY
    }

    public var area: Double {
        (maxX - minX) * (maxY - minY)
    }

    public var margin: Double {
        (maxX - minX) + (maxY - minY)
    }

    public func enlargedArea(for box: Box) -> Double {
        (max(box.maxX, maxX) - min(box.minX, minX)) * (max(box.maxY, maxY) - min(box.minY, minY))
    }

    public func intersectedArea(on box: Box) -> Double {
        let minX = max(minX, box.minX)
        let minY = max(minY, box.minY)
        let maxX = min(maxX, box.maxX)
        let maxY = min(maxY, box.maxY)

        return max(0, maxX - minX) * max(0, maxY - minY)
    }

    public mutating func enlarge(for box: Box) {
        minX = min(minX, box.minX)
        minY = min(minY, box.minY)
        maxX = max(maxX, box.maxX)
        maxY = max(maxY, box.maxY)
    }

    public static var infinity = Box(minX: .infinity, minY: .infinity, maxX: -.infinity, maxY: -.infinity)
}
