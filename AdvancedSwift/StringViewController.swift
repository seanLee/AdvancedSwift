//
//  StringViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/8/4.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

class StringViewController: UIViewController {

    public var _playgroundPrintHook:((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let single = "Pok\u{00E9}mon"
        let double = "Pok\u{0065}\u{0301}mon"
        
        print(single)
        print(double)
        
        for (i, c) in "hello".characters.enumerated() {
            print("\(i) and \(c)")
        }
        
        var steam = ArrayStream()
        print("Hello", to: &steam)
        print("World", to: &steam)
        print(steam.buffer)
    }
}

struct StringCoreClone {
    var _baseAddress: UnsafeMutableRawPointer?
    var _countAndFlags: UInt
    var _owner: AnyObject?
}

public struct Regex {
    fileprivate let regexp: String
    
    public init(_ regexp: String) {
        self.regexp = regexp
    }
}

struct ArrayStream: TextOutputStream {
    var buffer: [String] = []
    mutating func write(_ string: String) {
        buffer.append(string)
    }
}

protocol StringViewSelector {
    associatedtype View: Collection
    
    static var caret    : View.Iterator.Element {get}
    static var asterisk : View.Iterator.Element {get}
    static var period   : View.Iterator.Element {get}
    static var dollar   : View.Iterator.Element {get}
    
    static func view(from s: String) -> View
}

struct UTF8ViewSelector: StringViewSelector {
    static var caret:    UInt8 {return UInt8(ascii: "^")}
    static var asterisk: UInt8 {return UInt8(ascii: "*")}
    static var period:   UInt8 {return UInt8(ascii: ".")}
    static var dollar:   UInt8 {return UInt8(ascii: "$")}
    
    static func view(from s: String) -> String.UTF8View {return s.utf8}
}

struct CharacterViewSelector: StringViewSelector {
    static var caret:    Character { return "^" }
    static var asterisk: Character { return "*" }
    static var period:   Character { return "." }
    static var dollar:   Character { return "$" }
    
    static func view(from s: String) -> String.CharacterView { return s.characters }
}
