//
//  UITableViewCell.Extensions.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/3/8.
//

import UIKit


extension UITableViewCell {
    
    
    public func set(sectionRoundCornerRadius radius: CGFloat, atIndexPath indexPath: IndexPath, forView _view: UIView? = nil, inRect rect: CGRect? = nil) {
        if (radius <= 0) { return }
        var view: UIView = self
        for superview in superviews {
            if superview.isKind(of: UITableView.self) {
                view = superview
                break
            }
        }
        
        let cornerView = _view ?? self
        let bounds = rect ?? cornerView.bounds
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        let lastIndexPath = (view as! UITableView).numberOfRows(inSection: indexPath.section) - 1
        if (indexPath.row == 0 && indexPath.row == lastIndexPath) {
            shapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: radius, height: radius)).cgPath
            cornerView.layer.mask = shapeLayer
        }
        else if (indexPath.row == 0) {
            shapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
            cornerView.layer.mask = shapeLayer
        }
        else if (indexPath.row == lastIndexPath) {
            shapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
            cornerView.layer.mask = shapeLayer
        }
        else {
            cornerView.layer.mask = nil;
        }
    }
    
    
    
    
    
}
















