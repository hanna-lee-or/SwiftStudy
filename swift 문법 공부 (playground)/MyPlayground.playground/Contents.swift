
import UIKit

//MARK: - 스택과 큐 자료구조
struct Stack<T> {
    var isEmpty: Bool {
        return self.list.isEmpty
    }
    
    var top: T? {
        return self.list.last
    }
    
    mutating func push(_ item: T) {
        self.list.append(item)
    }
    
    mutating func pop() -> T? {
        return self.list.popLast()
    }
    
    private var list = [T]()
}

struct Queue<T> {
    var isEmpty: Bool {
        return self.list.isEmpty
    }
    
    var front: T? {
        return self.list.first
    }
    
    mutating func enqueue(_ item: T) {
        self.list.append(item)
    }
    
    mutating func dequeue() -> T? {
        guard self.isEmpty == false else {
            return nil
        }
        return self.list.removeFirst()
    }
    private var list = [T]()
}

//MARK: - 그래프 자료구조에 사용
class Node<T> {
    let value: T
    var edges = [Edge<T>]()
    var visited = false
    
    init(value: T) {
        self.value = value
    }
    
    func appendEdgeTo(_ node: Node<T>) {
        let edge = Edge<T>(from: self, to: node)
        self.edges.append(edge)
    }
}

class Edge<T> {
    weak var source: Node<T>?
    let destination: Node<T>
    
    init(from source: Node<T>, to destination: Node<T>) {
        self.source = source
        self.destination = destination
    }
}

//MARK: - BFS 최단경로 탐색
func practiceDFS(n lastNode: Int, edges: [(Int, Int)]) -> Int {
    var edgeInfo = [Int: Array<Int>]() // edge 정보를 setup
    for edge in edges {
        if var array = edgeInfo[edge.0] {
            array.append(edge.1)
            edgeInfo[edge.0] = array
        } else {
            edgeInfo[edge.0] = [edge.1]
        }
    }
    // 1. 궁극적으로 원하는 값 (재귀를 돌며 수집할 값)
    var result = 0
    
    func dfs(node: Int, visited: [Int]) {
        guard node != lastNode else {
            // 2. 재귀를 멈추는 조건
            result += 1
            return
        }
        guard let neighbors = edgeInfo[node] else {
            return
        }
        for edge in neighbors {
            // 현재의 노드에서 이동할 수 있는 노드 중, 아직 방문하지 않은 곳으로 가본다 (중복 방지)
            guard visited.contains(edge) == false else { continue }
            dfs(node: edge, visited: visited + [edge])
        }
    }
    // 3. 초기값으로 어떤 것을 넘길지
    dfs(node: 1, visited: [1])
    return result
}
    
var answer = practiceDFS(n: 5, edges: [(1, 2), (1, 3), (1, 4), (2, 1), (2, 4), (2, 5), (3, 2), (3, 4), (4, 5)])
print("DFS 모든 경로의 개수 : \(answer)")

//MARK: - BFS 최단경로 탐색
func practiceBFS(n: Int, edges: [(Int, Int)]) {
    // Node, Edge setup
    let nodes = (0..<n).map({ Node<Int>(value: $0 + 1) })
    
    for (from, to) in edges {
        nodes[from - 1].appendEdgeTo(nodes[to - 1])
    }
    // 1. 궁극적으로 원하는 값
    var shortest = Array(repeating: [1], count: n)
    var queue = Queue<Node<Int>>()
    queue.enqueue(nodes[0])
    nodes[0].visited = true
    
    while let node = queue.dequeue() {
        for edge in node.edges {
            let dest = edge.destination
            guard dest.visited == false else { continue }
            queue.enqueue(dest)
            dest.visited = true
            // 2. Node를 방문할 때 해야하는 처리
            shortest[dest.value - 1] = shortest[node.value - 1] + [dest.value]
        }
    }
    print(shortest)
}

print("\nBFS 1번 노드에서 다른 노드까지 가는 모든 최단 경로 탐색")
practiceBFS(n: 6, edges: [(1,5), (2,4), (2,5), (3,2), (3,6), (4,2), (4,5), (5,3), (5,6)])

//MARK: - 연결 리스트로 구현된 큐 자료구조
// 연결리스트에 사용되는 노드 클래스 (참조를 위해 클래스로 선언. 구조체는 값 복사.)
class LilnkedListNode<T> {
    let value: T
    weak var previous: LilnkedListNode?
    var next: LilnkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

// 연결 리스트
struct LinkedList<T> {
    var isEmpty: Bool {
        return self.head == nil
    }
    
    mutating func appendValue(_ value: T) {
        let new = LilnkedListNode<T>(value: value)
        if self.isEmpty {
            self.head = new
        }
        self.tail?.next = new
        new.previous = self.tail
        self.tail = new
    }
    
    mutating func removeHead() -> T? {
        guard let head = self.head else { return nil }
        return self.removeNode(head)
    }
    
    mutating func removeNode(_ node: LilnkedListNode<T>) -> T {
        node.previous?.next = node.next
        node.next?.previous = node.previous
        if self.head === node {
            self.head = nil
        }
        if self.tail === node {
            self.tail = nil
        }
        node.previous = nil
        node.next = nil
        return node.value
    }
    private(set) var head: LilnkedListNode<T>?
    private var tail: LilnkedListNode<T>?
}

// 연결 리스트로 구현된 큐 자료구조
struct QueueWithLinkedList<T> {
    var isEmpty: Bool {
        return self.linkedList.isEmpty
    }
    var front: T? {
        return self.linkedList.head?.value
    }
    mutating func enqueue(_ item: T) {
        self.linkedList.appendValue(item)
    }
    mutating func dequeue() -> T? {
        guard self.isEmpty else { return nil }
        return self.linkedList.removeHead()
    }
    private var linkedList = LinkedList<T>()
}

// 출처: https://wlaxhrl.tistory.com/87?category=842165 [찜토끼의 Swift 블로그]
