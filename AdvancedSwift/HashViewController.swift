//
//  HashViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/4/6.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

struct Person {
    var name:    String;
    var zipCode: Int;
    var birthday:Date;
    
}

extension Person:Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name;
    }
}

extension Person:Hashable {
    var hashValue: Int {
        return name.hashValue ^ zipCode.hashValue ^ birthday.hashValue;
    }
}

class HashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
