import Foundation

class BinaryTree<T: Equatable & Comparable> {
    var value: T
    var left: BinaryTree<T>?
    var right: BinaryTree<T>?

    var isLeaf: Bool {
        return left == nil && right == nil
    }

    init(value: T, left: BinaryTree<T>? = nil, right: BinaryTree<T>? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }

    @discardableResult
    func insert(_ element: T) -> BinaryTree<T> {
        return self.insert(tree: BinaryTree(value: element))
    }

    @discardableResult
    func insert(tree: BinaryTree<T>) -> BinaryTree<T> {
        if value > tree.value {
            if let left = left {
                return left.insert(tree: tree)
            } else {
                left = tree
            }
        } else {
            if let right = right {
                return right.insert(tree: tree)
            } else {
                right = tree
            }
        }
        return tree
    }

    func remove(_ element: T) -> BinaryTree<T>? {
        if element < value {
            left = left?.remove(element)
        } else if element > value {
            right = right?.remove(element)
        } else {
            guard let left = left else {
                return right
            }
            guard let right = right else {
                return left
            }

            value = BinaryTree.minValue(right)
            self.right = right.remove(element)
        }
        return self
    }

    private static func minValue(_ root: BinaryTree<T>) -> T {
        var root = root
        var minv = root.value
        while let left = root.left {
            minv = left.value
            root = left
        }
        return minv
    }

    func traverse(_ strategy: TraversalStrategy, _ handler: (T) throws -> Void) rethrows {
        try strategy.perform(tree: self, handler)
    }

    func contains(strategy: SearchStrategy, where predicate: (T) throws -> Bool) rethrows -> Bool {
        return (try search(using: strategy, where: predicate)) != nil
    }

    func search(using strategy: SearchStrategy, where predicate: (T) throws -> Bool) rethrows -> BinaryTree<T>? {
        return try strategy.perform(tree: self, where: predicate)
    }

    func reversed() -> BinaryTree<T> {
        let left = self.left?.reversed()
        let right = self.right?.reversed()
        return BinaryTree(value: value, left: right, right: left)
    }

    enum TraversalStrategy {
        case inorder
        case preorder
        case postorder

        func perform(tree: BinaryTree<T>, _ handler: (T) throws -> Void) rethrows {
            switch self {
            case .inorder:
                try inorderStrategy(tree: tree, handler)
            case .preorder:
                try preorderStrategy(tree: tree, handler)
            case .postorder:
                try postorderStrategy(tree: tree, handler)
            }
        }

        private func inorderStrategy(tree: BinaryTree<T>, _ handler: (T) throws -> Void) rethrows {
            if let left = tree.left {
                try inorderStrategy(tree: left, handler)
            }
            try handler(tree.value)
            if let right = tree.right {
                try inorderStrategy(tree: right, handler)
            }
        }

        private func preorderStrategy(tree: BinaryTree<T>, _ handler: (T) throws -> Void) rethrows {
            try handler(tree.value)
            if let left = tree.left {
                try preorderStrategy(tree: left, handler)
            }
            if let right = tree.right {
                try preorderStrategy(tree: right, handler)
            }
        }

        private func postorderStrategy(tree: BinaryTree<T>, _ handler: (T) throws -> Void) rethrows {
            if let left = tree.left {
                try postorderStrategy(tree: left, handler)
            }
            if let right = tree.right {
                try postorderStrategy(tree: right, handler)
            }
            try handler(tree.value)
        }
    }

    enum SearchStrategy {
        case breadthFirst
        case depthFirst

        func perform(tree: BinaryTree<T>, where predicate: (T) throws -> Bool) rethrows -> BinaryTree<T>? {
            switch self {
            case .breadthFirst:
                return try breadthFirstSearchStrategy(tree: tree, where: predicate)
            case .depthFirst:
                return try depthFirstSearchStrategy(tree: tree, where: predicate)
            }
        }

        private func breadthFirstSearchStrategy(tree: BinaryTree<T>, where predicate: (T) throws -> Bool) rethrows -> BinaryTree<T>? {
            var queue: [BinaryTree<T>] = []
            queue.append(tree)
            while !queue.isEmpty {
                guard let node = queue.popFirst() else {
                    return nil
                }
                if try predicate(node.value) {
                    return node
                }
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            return nil
        }

        private func depthFirstSearchStrategy(tree: BinaryTree<T>, where predicate: (T) throws -> Bool) rethrows -> BinaryTree<T>? {
            var stack: [BinaryTree<T>] = []
            stack.append(tree)
            while !stack.isEmpty {
                guard let node = stack.popLast() else {
                    return nil
                }
                if try predicate(node.value) {
                    return node
                }
                if let left = node.left {
                    stack.append(left)
                }
                if let right = node.right {
                    stack.append(right)
                }
            }
            return nil
        }
    }
}
