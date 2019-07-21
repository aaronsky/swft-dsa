class LRUCache<Key: Hashable, Element> {
    private var capacity: Int
    private var cache: [Key: Element] = [:]
    private var priority: DoublyLinkedList<Key> = []
    private var mapCacheKeysToNodes: [Key: DoublyLinkedList<Key>.Node] = [:]

    var count: Int {
        return cache.count
    }

    init(capacity: Int) {
        self.capacity = capacity
    }

    subscript(key: Key) -> Element? {
        /// O(1)
        get {
            guard let element = cache[key] else {
                return nil
            }
            remove(key)
            insert(key, element)
            return element
        }
        /// O(1)
        set {
            assert(cache.count == priority.count)
            assert(priority.count == mapCacheKeysToNodes.count)
            if cache[key] != nil {
                remove(key)
            } else if priority.count >= capacity, let leastRecentlyUsedKey = priority.tail?.value {
                remove(leastRecentlyUsedKey)
            }
            guard let value = newValue else {
                return
            }
            insert(key, value)
        }
    }

    /// O(1)
    private func insert(_ key: Key, _ element: Element) {
        cache[key] = element
        priority.prepend(key)
        guard let node = priority.head else {
            return
        }
        mapCacheKeysToNodes[key] = node
    }

    /// O(n)
    private func remove(_ key: Key) {
        cache.removeValue(forKey: key)
        guard let node = mapCacheKeysToNodes[key] else {
            return
        }
        priority.remove(node: node)
        mapCacheKeysToNodes.removeValue(forKey: key)
    }
}
