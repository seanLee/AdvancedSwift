//
//  StackViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/6/17.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

protocol Stack {
    associatedtype Element
    
    mutating func push(_: Element)
    
    mutating func pop() -> Element?
}

class StackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var stack:Array<Int> = [3, 2, 1]
        var a = stack
        var b = stack
        
        print(a.pop())
        print(a)
        print(a.pop())
        print(a)
        print(a.pop())
        print(a)
        
        print(stack)
        print(b)
        
        let c = List<Int>.end.cons(1).cons(2).cons(3)
    }
}

extension Array: Stack {
    mutating func push(_ x: Element) {append(x)}
    
    mutating func pop() -> Element? {return popLast()}
}

