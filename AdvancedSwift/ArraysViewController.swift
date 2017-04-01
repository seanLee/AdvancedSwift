//
//  Arrays.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/3/31.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

infix operator *||*;
func *||* (result: Int, item: Int) -> Int {
    return result + item;
}

class ArraysViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var fibs = [0, 1, 1, 2, 3, 5];
        
        fibs.append(8);
        fibs.append(contentsOf: [13, 21]);
        
        let squared = fibs.map{fib in fib * fib};
        print(squared);
        
        // MARK: - Copy
        let a = NSMutableArray(array: [1, 2, 3]);
        
        let b: NSArray = a;
        let c = a.copy() as! NSArray;
        
        print("a is at \(NSString.init(format: "%p", a))");
        print("b is at \(NSString.init(format: "%p", b))");
        print("c is at \(NSString.init(format: "%p", c))");
        
        a.add(4);
        
        print("a is \(b.classForCoder) and value is \(a)");
        print("b is \(b.classForCoder) and value is \(b)");
        print("c is \(c.classForCoder) and value is \(c)");
        
        // MARK: - Customer function
        let names = ["Alex", "Ben", "Chris", "Den", "Elen"];
        let matches = names.last{$0.hasPrefix("D")};
        if let matchItem = matches {
            print("match item is \(matchItem)");
        }
        
        print("sum function result : \([1, 2, 3, 4].accumulate(1, *||*))");
        
        print("filter function result : \([1, 3, 5, 8, 10].filter{$0 % 2 == 0})");
        
        print("all function result : \([1, 5, 9, 11, 10].all{$0 % 2 == 0})");
        
        print("reduce function result : \(fibs.reduce(0, +))");
        
        print("word combines to \(["h", "e", "l", "l", "o"].reduce(""){$0 + $1})");
        
        print("customize map function \([3, 6, 9, 11].map2{Int(pow(Double($0), 3.0))})");
        
        print("customize filter function \([7, 8, 9, 10, 11, 12, 13, 14].filter2{$0 % 3 == 0})");
        
        // MARK: - Poker
        let suits = ["♠", "♥", "♣", "♦"];
        let ranks = ["J", "Q", "K", "A"]
        let result = suits.flatMap { suit in
            ranks.map{(suit, $0)};
        }
        print(result);
        
        suits.forEach {print("forEach item is \($0)")};
        
        let slice = fibs[1..<fibs.endIndex];
        print(slice);
        print(type(of: slice));
    }
}

extension Sequence {
    func last(where predicate:(Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) {
            return element;
        }
        return nil;
    }
    
    func all(_ predicate:(Iterator.Element) -> Bool) -> Bool {
        return contains{predicate($0)};
    }
}

extension Array {
    func accumulate<Result>(_ instialResult:Result, _ nextPartialResult:(Result , Element) -> Result) -> [Result] {
        var running = instialResult;
        return map {
            running = nextPartialResult(running, $0);
            return running;
        }
    }
    
    func map2<T>(_ transform:(Element) -> T) -> [T] {
        return reduce([], {$0 + [transform($1)]});
    }
    
    func filter2(_ isIncluded:(Element) -> Bool) -> [Element] {
        return reduce([]) {isIncluded($1) ? $0 + [$1] : $0};
    }
}
