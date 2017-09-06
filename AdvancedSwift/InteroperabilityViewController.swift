//
//  InteroperabilityViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/9/5.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

class InteroperabilityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let b1 = B1()
        print(b1.method1())
        
        let a1: A1 = B1()
        print(a1.method1())
    }
}

protocol A1 {
    func method1() -> String
}

struct B1 : A1 {
    func method1() -> String {
        return "Hello"
    }
}

protocol A2 {
    func method1() -> String
}

extension A2 {
    func method1() -> String {
        return "hi"
    }
    
    func method2() -> String {
        return "hi"
    }
}

struct B2: A2 {
    func method1() -> String {
        return "hello"
    }
    
    func method2() -> String {
        return "hello"
    }
}

class Parent {
    final func method() {
        print("开始配置")
        
        methodImpl()
        
        print("结束配置")
    }
    
    func methodImpl() {
        fatalError("子类必须实现")
    }
}

class Child: Parent {
    
}
