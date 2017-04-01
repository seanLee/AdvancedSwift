//
//  DictionaryViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/4/1.
//  Copyright © 2017年 public. All rights reserved.
//

enum Setting {
    case text(String)
    case int(Int)
    case bool(Bool)
}

import UIKit

class DictionaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaultSetting :[String: Setting] = [
            "Airplane Mode":.bool(true),
            "Name"         :.text("My iPhone")
        ]
        
        print(defaultSetting["Name"]!);
    }
}
