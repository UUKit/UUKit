//
//  UUSearchBar.swift
//  Pods
//
//  Created by uxiu.me on 2019/3/7.
//

import UIKit

open class UUSearchBar: UISearchBar {
    
    var preferredFont: UIFont?
    var preferredTextColor: UIColor?
    
    convenience init(frame: CGRect, font: UIFont, textColor: UIColor) {
        self.init()
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        searchBarStyle = UISearchBar.Style.prominent
        isTranslucent = false
        
    }
    
    func indexOfSearchFieldInSubviews() -> Int {
        var index: Int!
        let searchBarView = subviews[0]
        for (i,subview) in searchBarView.subviews.enumerated() {
            if subview.isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        return index
    }
    
    override open func draw(_ rect: CGRect) {
        if let searchField = subviews[0].subviews[indexOfSearchFieldInSubviews()] as? UITextField {
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
        }
        super.draw(rect)
    }
    
    
}
