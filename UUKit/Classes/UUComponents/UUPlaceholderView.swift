//
//  UUPlaceholder.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/5/18.
//

import Foundation
import UIKit

typealias UUPlaceholderViewHandle = () -> ()

class UUPlaceholderView: UIView {
    
    lazy var imgv = UIImageView(image: .init(named: ""))
    lazy var textButton = UIButton(type: .custom)
    lazy var descButton = UIButton(type: .custom)
    var handle: UUPlaceholderViewHandle?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

