//
//  ProtocolViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/9/2.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

class ProtocolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var iter = IntIterator(ConstantIterator())
        iter = IntIterator([1,2,3].makeIterator())
    }
}

class IteratorStore<I: IteratorProtocol> where I.Element == Int {
    var iterator: I
    
    init(iterator: I) {
        self.iterator = iterator
    }
}

class IntIterator {
    var nextImpl:() -> Int?
    
    init<I: IteratorProtocol>(_ iterator: I) where I.Element == Int {
        var iteratorCopy = iterator
        self.nextImpl = {iteratorCopy.next()}
    }
}

extension IntIterator: IteratorProtocol {
    func next() -> Int? {
        return nextImpl()
    }
}

struct ConstantIterator: IteratorProtocol {
    mutating func next() -> Int? {
        return 1
    }
}

class IteratorBox<A>: IteratorProtocol {
    func next() -> A? {
        fatalError("This method is abstract")
    }
}

class IteratorBoxHelper<I: IteratorProtocol>: IteratorBox<I.Element> {
    var iterator: I
    
    init(iterator: I) {
        self.iterator = iterator
    }
    
    override func next() -> I.Element? {
        return iterator.next()
    }
}
