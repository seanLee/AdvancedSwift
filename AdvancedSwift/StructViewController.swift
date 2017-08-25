//
//  StructViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/7/22.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

class StructViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var origin = Point(x: 0, y: 0)
        origin.x = 10
        print(origin)
        
        var screen = [Rectangle(width: 320, height: 480)] {
            didSet {
                print("Value changed")
            }
        }
        screen[0].origin.x = 10
        
        let someBytes = MyData(NSData(base64Encoded: "wAEP/W==", options: [])!)
        var empty = MyData(NSData())
        let emptyCopy = empty
        for _ in 0..<5 {
            empty.append(someBytes)
        }
        print(empty._data.unbox)
        print(emptyCopy._data.unbox)
        
        var d = ContainerStruct(storage: COWStruct())
        print(d.storage.change())
        print(d["value"].change())
    }
    
    func log(condition: Bool,
             message: @autoclosure () -> String,
             file: String = #file, line function: String = #function, line: Int = #line) {
        if condition {return}
        print("\(message()),\(file):\(function)(line\(line))")
    }
}

// MARK: - Rectangle
struct Point {
    var x: Int
    var y: Int
}

struct Size {
    var width: Int
    var height: Int
}

struct Rectangle {
    var origin: Point
    var size: Size
}

extension Rectangle {
    init(x: Int = 0, y: Int = 0, width: Int, height: Int) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
}

// MARK: - Data
final class Box<T> {
    var unbox: T
    init(_ value: T) {
        self.unbox = value
    }
}

struct MyData {
    fileprivate var _data: Box<NSMutableData>
    var _dataForWriting: NSMutableData {
        mutating get {
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("Making a copy")
            }
            return _data.unbox
        }
    }
    init(_ data: NSData) {
        _data = Box(data.mutableCopy() as! NSMutableData)
    }
}

extension MyData {
    mutating func append(_ other: MyData) {
        _dataForWriting.append(other._data.unbox as Data)
    }
}

// MARK: - Empty
final class Empty {
    
}

struct COWStruct {
    var ref = Empty()
    
    mutating func change() -> String {
        if isKnownUniquelyReferenced(&ref) {
            return "No Copy"
        } else {
            return "Copied"
        }
    }
}

// MARK: - BinaryScanner
class BinaryScanner {
    var position: Int
    let data: Data
    init(data: Data) {
        self.position = 0
        self.data = data
    }
}

extension BinaryScanner {
    func scanByte() -> UInt8? {
        guard position < data.endIndex else {return nil}
        position += 1
        return data[position - 1]
    }
    
    func scanRemainingBytes() {
        while let byte = self.scanByte() {print(byte)}
    }
}

// MARK: - ContainerStruct
struct ContainerStruct<T> {
    var storage: T
    subscript(s: String) -> T {
        get {return storage}
        set {storage = newValue}
    }
}

// MARK: - Range
struct RangeStart<I> {let start: I}
struct RangeEnd<I> {let start: I}

postfix operator ..<
postfix func ..<<I>(lhs: I) -> RangeStart<I> {
    return RangeStart(start: lhs)
}

prefix operator ..<
prefix func ..<<I>(rhs: I) -> RangeEnd<I> {
    return RangeEnd(start: rhs)
}

extension Collection {
    subscript(r: RangeStart<Index>) -> SubSequence {
        return suffix(from: r.start)
    }
    
    subscript(r: RangeEnd<Index>) -> SubSequence {
        return prefix(upTo: r.start)
    }
}

extension Dictionary {
    subscript(key: Key, or defaultValue: Value) -> Value {
        get {
            return self[key] ?? defaultValue
        }
        set {
            self[key] = newValue
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    var frequencies: [Iterator.Element: Int] {
        var result: [Iterator.Element: Int] = [:]
        for x in self {
            result[x, or:0] += 1
        }
        return result
    }
}
