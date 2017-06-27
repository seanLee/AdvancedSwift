//
//  SequenceViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/6/9.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

class SequenceViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        var iterator = [1, 3, 5, 7, 9].makeIterator()
        //        while let element = iterator.next() {
        //            print("element is \(element)")
        //        }
        
        //        var constantIterator = FibsIterator()
        //        while let item = constantIterator.next() {
        //            print(item)
        //        }
        
        //        PrefixSequence(string: "Sean").map {
        //
        //            print($0.uppercased())
        //        }
        
        //
        //        let randomNumbers = sequence(first: 10000) { (previous: UInt32) in
        //            let newValue = arc4random_uniform(previous);
        //            print(previous)
        //            guard newValue > 0 else {return nil}
        //            return newValue
        //        }
        //        print(Array(randomNumbers))
        
        let numbers = [1, 2, 3, 4]
        let squares = numbers.map {$0 * $0}
        let numberIndex = numbers.index(of: 4)
        if let numberIndex = numberIndex {
            print(squares[numberIndex])
        }
        
        let fibsSequence = AnySequence(fibsIterator)
        print(Array(fibsSequence.prefix(10)))
        
        let fibsSequence2 = sequence(state: (0, 1)) {
            (state: inout(Int, Int)) -> Int? in
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
        
        print(Array(fibsSequence2.prefix(10)))
        
        print([1, 2, 3, 2, 1].headMirrorsTail(2))
        
        print(List<Int>.end.cons(1).cons(2).cons(3))
        
        print([3, 2, 1] as List)
    }
    
    func fibsIterator() -> AnyIterator<Int> {
        var state = (0, 1)
        return AnyIterator {
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
    }
}

struct ConstantIterator: IteratorProtocol {
    mutating func next() -> Int? {
        return 1
    }
}

struct FibsIterator: IteratorProtocol {
    var state = (0, 1)
    var currentIndex = 0;
    mutating func next() -> Int? {
        
        currentIndex = currentIndex + 1
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        print("index is \(currentIndex) and 0 is \(state.0) and 1 is \(state.1)")
        return upcomingNumber
    }
}

struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    
    mutating func next() -> String? {
        guard offset < string.endIndex else {
            return nil;
        }
        offset = string.index(after: offset)
        print(offset)
        return string[string.startIndex..<offset]
    }
}

struct PrefixSequence: Sequence {
    let string: String
    
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

extension Sequence where
    Iterator.Element: Equatable,
    SubSequence:Sequence,
SubSequence.Iterator.Element == Iterator.Element {
    func headMirrorsTail(_ n: Int) -> Bool {
        let head = prefix(n)
        let tail = suffix(n).reversed()
        return head.elementsEqual(tail)
    }
}

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>:Queue {
    fileprivate var left:  [Element] = []
    fileprivate var right: [Element] = []
    
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

//extension FIFOQueue: RangeReplaceableCollection {
//    mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == Element {
//        right = left.reversed() + right
//        left.removeAll()
//        right.replaceSubrange(subrange, with: newElements)
//    }
//}

enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List {
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { $0.cons($1)}
    }
}
