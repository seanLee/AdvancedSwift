//
//  OptionalViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/6/27.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

class OptionalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var a:[()->Int] = []
        
        var g = (1...3).makeIterator()
        var o: Int? = g.next()
        while o != nil {
            let i = o!
            a.append{i}
            o = g.next()
        }
        
        for function in a {
            print(function())
        }
        
        let stringNumbers = ["1", "2", "three"]
        let maybeInts = stringNumbers.map{Int($0)}
        
        print(maybeInts)
        
        var iterator = maybeInts.makeIterator()
        while let maybeInt = iterator.next() {
            print("maybeInt is \(maybeInt)")
        }
        
        for case let i? in maybeInts {
            print("for case is \(i)", terminator: "\n")
        }
        
        let searchIndex = 5
        if case 0..<10 = searchIndex {
            print("\(searchIndex) within range")
        }
        
        let string = "Taylor Swift"
        if case Substring("Swift") = string {
            print("has Swift")
        }
    }
}

struct Substring {
    let s: String
    init(_ s: String) {
        self.s = s
    }
}

func ~=(pattern: Substring, value: String) -> Bool {
    return value.range(of: pattern.s) != nil
}
