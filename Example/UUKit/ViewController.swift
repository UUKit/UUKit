//
//  ViewController.swift
//  UUKit
//
//  Created by uukit@uxiu.me on 04/09/2021.
//  Copyright (c) 2021 uukit@uxiu.me. All rights reserved.
//

import UIKit
import UUKit

class ViewController: UIViewController {

    var str: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UUKit"
        
        let btn = UIButton(backgroundColor: .green, frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        view.addSubviews(btn)
        print(Date().weekday)
        print(str.isSome)
        
        btn.setBorder(30, UIColor(hex: 0xff0ff0)).setRoundCorner(direction: .topLeft)
        
        let btn1 = UIButton(backgroundColor: .green, frame: CGRect(x: 100, y: 410, width: 200, height: 200))
        btn1.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        view.addSubviews(btn1)
        
        
        let arr = ["123","456",nil]
        print(arr.toJSON() ?? "")
        
        
    }
    
    @objc func clicked() {
        getContact { (name, phone) in
            //print("\(name)的电话号码是\(phone)")
        }
    }


}

