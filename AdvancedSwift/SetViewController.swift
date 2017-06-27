//
//  SetViewController.swift
//  AdvancedSwift
//
//  Created by Sean on 2017/6/6.
//  Copyright © 2017年 public. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        let naturals: Set = [1, 2, 3, 2]
        print(naturals)
        
        
        let iPods: Set = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffle", "iPod Classic"]
        let discontinuedIPods: Set = ["iPod mini", "iPod Classic", "iPod"]
        print(iPods.subtracting(discontinuedIPods))
        print(iPods.intersection(discontinuedIPods))
        
        var discountinued: Set = ["iBook", "Powerbook", "Power Mac"]
        discountinued.formUnion(discontinuedIPods)
        print(discountinued)
        
        let singleDigitNumber = 0...9
        
        let lowercaseLetters = Character("a")...Character("z")
        
        let digitMap = singleDigitNumber.map {$0 * $0}
        
        for index in singleDigitNumber {
            print("index is \(index)")
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}
