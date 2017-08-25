//
//  GenericViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/8/18.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let result: Double = 2 ** 3
        print(result)
        
        let one2three = [1, 2, 3]
        let five2one = [5, 4, 3, 2, 1]
        print(one2three.isSubset(of: five2one))
        
    }
}

precedencegroup ExponentiationPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence

func **(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}

func **(lhs: Float, rhs: Float) -> Float {
    return powf(lhs, rhs)
}

func **<Number:SignedInteger>(lhs: Number, rhs: Number) -> Number {
    let result = Double(lhs.toIntMax()) ** Double(rhs.toIntMax())
    return numericCast(IntMax(result))
}

extension Sequence where Iterator.Element: Hashable {
    func isSubset(of other:[Iterator.Element]) -> Bool {
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element) else {
                return false
            }
        }
        return true
    }
}

extension Array {
    func binarySearch (for value: Element, areInIncreasingOrder:(Element, Element) -> Bool) -> Int? {
        var left = 0
        var right = count - 1
        
        while left <= right {
            let mid = (left + right)/2
            let candidate = self[mid]
            
            if areInIncreasingOrder(candidate, value) {
                left = mid + 1
            } else if areInIncreasingOrder(value, candidate) {
                right = mid - 1
            } else {
                return mid
            }
        }
        return nil
    }
    
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + 1
            
            guard i != j else {continue}
            
            swap(&self[i], &self[j])
        }
    }
    
    func shuffled() -> [Element] {
        var clone = self
        clone.shuffle()
        return clone
    }
}

extension Array where Element: Comparable {
    func binarySearch(for value: Element) -> Int? {
        return self.binarySearch(for: value, areInIncreasingOrder: <)
    }
}

extension SignedInteger {
    static func arc4random_uniform(_ upper_bound: Self) -> Self {
        precondition(upper_bound > 0
            && upper_bound.toIntMax() < UInt32.max.toIntMax(),
                     "arc4random_uniform only callable up to \(UInt32.max)")
        return numericCast(Darwin.arc4random_uniform(numericCast(upper_bound)))
    }
}
