//
//  OptionalViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/6/27.
//  Copyright © 2017年 public. All rights reserved.
//

infix operator !!
infix operator !?

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

        
        var stringNumbers = ["1", "2", "three"]
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
        
        let ages = ["Tim": 53, "Angela": 54, "Craig": 44,
                    "Jony": 47, "Chris": 37, "Micheal": 34]
        let result = ages.filter {$0.value < 50 }.map {$0.key}.sorted()
        print(result)
        
//        let fooString = "foo"
//        let i = Int(fooString) !! "Expecting integer, got \"\(fooString)\""
//        print(i)
        
//        print(Int(fooString) !? (10086, "Expected integer"))
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

func !!<T> (wrapped: T?, failureText: @autoclosure ()-> String) -> T {
    if let x = wrapped {return x}
    fatalError(failureText())
}

func !?<T> (wrapped: T?, nilDefault: @autoclosure () -> (value:T, text:String)) -> T {
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}

extension Array {
    func reduce(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        guard let fst = first else {return nil}
        print("now is \(self)")
        return dropFirst().reduce(fst, nextPartialResult)
    }
}

func flatten<S:Sequence, T> (source: S) -> [T] where S.Iterator.Element == T? {
    let filtered = source.lazy.filter {$0 != nil}
    return filtered.map {$0!}
}
