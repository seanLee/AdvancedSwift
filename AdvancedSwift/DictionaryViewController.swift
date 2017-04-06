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
            "Name"         :.text("My iPhone"),
            "Seat"         :.int(60)
        ]
        
        print(defaultSetting["Name"]!);
        
        var localizedSetting = defaultSetting;
        localizedSetting["Name"] = .text("Mein iPhone");
        localizedSetting["Do Not Disturb"] = .bool(true);
        
        let oldName = localizedSetting.updateValue(.text("Il mio iPhone"), forKey: "Name");
        print("\(String(describing: oldName))");
        
        var overriddenSettings:[String: Setting] = ["Name": .text("Jane's iPhone")];
        print("before merge: \(overriddenSettings)");
        overriddenSettings.merge(defaultSetting);
        print("after merge: \(overriddenSettings)");
        
        let defaultAlarms = (1..<5).map {(key:"Alarm\($0)", value:false)};
        print("defaultAlarms is \(defaultAlarms)");
        let alarmsDictionary = Dictionary(defaultAlarms);
        print("alarmsDictionary is \(alarmsDictionary)");
        
        
        print("before parse value : \(defaultSetting)");
        let parsingSetting = defaultSetting.mapValues { setting -> String in
            switch setting {
            case .text(let text):   return text;
            case .int(let number):  return String(number);
            case .bool(let value):  return value ? "是":"否";
            }
        };
        print("after parse value : \(parsingSetting)");
    }
}

extension Dictionary {
    mutating func merge<S>(_ other:S)
        where S:Sequence, S.Iterator.Element == (key: Key, value: Value) {
            for (k, v) in other {
                self[k] = v;
            }
    }
    
    init<S: Sequence>(_ sequence:S)
        where S.Iterator.Element == (key: Key, value: Value) {
            self = [:];
            self.merge(sequence);
    }
    
    func mapValues<NewValue>(transform: (Value) -> NewValue) -> [Key: NewValue] {
        return Dictionary<Key, NewValue>(map{key, value in
            return (key, transform(value));
        });
    }
}
