//
//  ClosureViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/7/27.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

typealias Block = () -> String

class ClosureViewController: UIViewController {
    
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var myWindow: Window? = Window()
        var view:View? = View(window: myWindow!)
        myWindow?.rootView = view!
        
        myWindow?.onRotate = {
            print("\(view!)")
        }
        
        view = nil
        myWindow = nil
        
        var people = [Person("A", last: "A", yearOfBirth: 1971),
                      Person("B", last: "B", yearOfBirth: 1972),
                      Person("C", last: "C", yearOfBirth: 1973),
                      Person("D", last: "D", yearOfBirth: 1986),
                      Person("E", last: "E", yearOfBirth: 1975),
                      Person("F", last: "F", yearOfBirth: 1974)]
        
        let sortByYear: SortDescriptor<Person> = sortDescriptor(<) { $0.yearOfBirth }
        people.sort(by: sortByYear)
        
        var x = 0
        incrementTenTimes(value: &x)
        print("after ten times plus \(x)")
    }
    
    
    typealias SortDescriptor<Value> = (Value, Value) -> Bool
    
    func sortDescriptor<Value, Key> (
        _ areInIncreasingOrder: @escaping (Key, Key) -> Bool,
        _ key: @escaping (Value) -> Key)
        -> SortDescriptor<Value> {
            return {
                print("first is \(key($0)) and second is \(key($1))")
                return areInIncreasingOrder(key($0), key($1))
            }
    }
    
    func incrementTenTimes(value: inout Int) {
        func inc() {
            value += 1;
        }
        
        for _ in 0..<10 {
            inc()
        }
    }
    
    func incref(pointer: UnsafeMutablePointer<Int>) -> (() -> Int) {
        return {
            pointer.pointee += 1
            return pointer.pointee
        }
    }
}

fileprivate class View {
    unowned var window: Window
    
    init(window: Window) {
        self.window = window;
    }
    
    deinit {
        print("Deinit View")
    }
}

fileprivate class Window {
    weak var rootView: View?
    
    deinit {
        print("Deinit Window")
    }
    
    var onRotate:(() -> ())?
}

// MARK: - Person
final class Person: NSObject {
    var first: String
    var last : String
    var yearOfBirth: Int
    init(_ first: String, last: String, yearOfBirth: Int) {
        self.first = first;
        self.last = last;
        self.yearOfBirth = yearOfBirth;
    }
}

class AlertView {
    var buttons: [String]
    var buttonTapped: ((Int) -> ())?
    
    init(buttons: [String] = ["OK", "Cancel"]) {
        self.buttons = buttons
    }
    
    func fire() {
        buttonTapped!(1)
    }
}

struct TapLogger {
    var taps: [Int] = []
    
    mutating func logTap(index: Int) {
        taps.append(index)
    }
}

// MARK: - GPSTrack
