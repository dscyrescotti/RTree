# 🌲 RTree

**RTree** implements [R-tree](https://en.wikipedia.org/wiki/R-tree) data structure in Swift for spatial indexing in a two-dimentional coordinate space.

## 💡 Features
**RTree** currently supports the following methods to manage 2D spatial data.
- [Retrieval](#retrieval)
- [Insertion](#insertion)
- [Removal](#removal)
- [Search](#search)

### Retrieval <a id="retrieval"></a>
`traverse()` retrieves an array with all spatial data stored in the R-tree.
```swift
let rTree = RTree<Int>()
rTree.retrieve() // an array of integers
```
> Note: Please be aware that `traverse()` does not guarantee that the result will maintain the order of your insertion.

### Insertion <a id="insertion"></a>
A spatial data can be inserted into the R-tree using `insert(_:in:)`. It requires you to specify a bounding box as the spatial index.
```swift
let rTree = RTree<Int>()
let box = Box(minX: -10, minY: -10, maxX: 10, maxY: 10) // a bounding box
rTree.insert(0, in: box) // inserted at the spatial coordinate of (0, 0)
```

### Removal <a id="removal"></a>
A spatial data can be removed from the R-tree using `remove(_:in:)` which returns the removed data if it is found in a specified boundary.
```swift
let rTree = RTree<Int>()
let box = Box(minX: -10, minY: -10, maxX: 10, maxY: 10) // a bounding box
rTree.remove(0, in: box) // removed
```

### Search <a id="search"></a>
`search(box:)` retrieves an array of some spatial data inside a specific bounding box within the R-tree.
```swift
let rTree = RTree<Int>()
let box = Box(minX: -10, minY: -10, maxX: 10, maxY: 10) // a bounding box
rTree.search(box: box) // an array of some spatial data
```

## 🛠 Installation 
### 📦 Using Swift Package Manager
Add it as a dependency within your Package.swift.
```swift
dependencies: [
    .package(url: "https://github.com/dscyrescotti/RTree.git", from: "1.0.0")
]
```

## © License
**RTree** is available under the MIT license. See the  [LICENSE](/LICENSE)  file for more info.