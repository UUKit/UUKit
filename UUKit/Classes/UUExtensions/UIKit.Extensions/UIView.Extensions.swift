//
//  UIViewExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/4.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIView {
    
    public convenience init(backgroundColor: UIColor = .clear, frame: CGRect = CGRect.zero) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
    }
    
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    @discardableResult
    public func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
    
    @discardableResult
    public func add(to superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
    
    func test() {
        
        
    }
    
}

extension UIView {
    
    //MARK: - ———————————— Gradient Color ————————————
    /// 设置渐变背景色
    ///
    /// - Parameters:
    ///   - colors: 渐变颜色数组，需要和 locations 数组一一对应
    ///   - locations: 渐变色分段数组，数值为 0~1 之间的float值
    ///   - startPoint: 渐变色的起始位置
    ///   - endPoint: 渐变色的结束位置
    public func setGradientLayer(colors: [UIColor] = [UIColor(hex: 0xCC0422), UIColor(hex: 0x7D0014)], locations: [NSNumber]? = nil, startPoint: CGPoint = CGPoint(x: 0.1, y: 0), endPoint: CGPoint = CGPoint(x: 0.9, y: 0)) {
        var cgColors = [CGColor]()
        for color: UIColor in colors {
            cgColors.append(color.cgColor)
        }
        if layer.isKind(of: CAGradientLayer.self) {
            (layer as! CAGradientLayer).colors = cgColors
            (layer as! CAGradientLayer).locations = locations
            (layer as! CAGradientLayer).startPoint = startPoint
            (layer as! CAGradientLayer).endPoint = endPoint
            (layer as! CAGradientLayer).frame = self.bounds
        }
    }
    
    //MARK: - ———————————— RoundedCorner ————————————
    /// 裁剪圆角
    ///
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - direction: 圆角位置，左上，右上，左下，右下，可组合搭配
    /// - Returns: 裁切完成的View
    @discardableResult public func setRoundCorner(radius: CGFloat? = nil, direction: UIRectCorner? = nil) -> Self {
        let _radius = radius ?? (bounds.height / 2.0)
        guard let _direction = direction else {
            layer.cornerRadius  = _radius
            layer.masksToBounds = true//ios9以后不会造成离屏渲染
            return self
        }
        let radii = CGSize(width: _radius, height: _radius)
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: _direction,
                                    cornerRadii: radii)
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        guard let _borderColor = layer.borderColor, layer.borderWidth > 0 else { return self }
        return setBorder(layer.borderWidth, UIColor(cgColor: _borderColor))
    }
    
    //MARK: - ———————————— ViewBorder ————————————
    /// 设置边框
    ///
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    /// - Returns: 边框设置完成的view
    @discardableResult public func setBorder(_ width: CGFloat, _ color: UIColor) -> Self {
        guard let shapeLayer = layer.mask as? CAShapeLayer, let path = shapeLayer.path else {
            layer.borderWidth = width
            layer.borderColor = color.cgColor
            return self
        }
        let borderLayer = CAShapeLayer()
        borderLayer.path = path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        //path是从边框的中心位置计算的,maskLayer外围还有一半未显示
        borderLayer.lineWidth = width * 2
        layer.addSublayer(borderLayer)
        return self
    }
    
    //MARK: - ———————————— ViewShadow ————————————
    /// 设置阴影
    ///
    /// - Parameters:
    ///   - color: 阴影的颜色
    ///   - offset: 阴影的偏移量
    ///   - radius: 圆角
    ///   - opacity: 不透明度
    public func setShadow(_ color: UIColor, _ offset: CGSize = CGSize(width: 4.0, height: 4.0), _ radius: CGFloat = 4.0, _ opacity: CGFloat = 0.8) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = Float(opacity)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    }
    
    
    
}


public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let _cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: _cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var zPosition: CGFloat {
        get {
            return layer.zPosition
        }
        
        set {
            layer.zPosition = newValue
        }
    }
    
}


extension UIView {
    
    /// 一个 view 的父视图，以及父视图的父视图，递归获取数组
    public var superviews: [UIView] {
        var arrm = [UIView]()
        var view = self
        while view.superview != nil {
            arrm.append(view.superview!)
            view = view.superview!
        }
        return arrm
    }
    
    /// 一个 view 的子视图，以及子视图的子视图，递归获取数组
    public var allSubviews: [UIView] {
        var allSubviews = [UIView]()
        for subview in subviews {
            allSubviews += subview.allSubviews
            allSubviews.append(subview)
        }
        return allSubviews
    }
    
    /// 根据事件响应者链获取最顶部的 View Controller
    var controller: UIViewController? {
        let responder: UIResponder? = sequence(first: self, next: { $0.next }).first(where: { $0 is UIViewController })
        return responder as? UIViewController
    }
    
    
}

extension UIView {
    /// 将当前视图转为UIImage
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

/// 抖动方向枚举
public enum ShakeDirection: Int {
    case horizontal  //水平抖动
    case vertical  //垂直抖动
}

extension UIView {
    
    /**
     扩展UIView增加抖动方法
     
     @param direction：抖动方向（默认是水平方向）
     @param times：抖动次数（默认5次）
     @param interval：每次抖动时间（默认0.1秒）
     @param delta：抖动偏移量（默认2）
     @param completion：抖动动画结束后的回调
     */
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 5,
                      interval: TimeInterval = 0.1, delta: CGFloat = 2,
                      completion: (() -> Void)? = nil) {
        //播放动画
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
                case .horizontal:
                    self.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                    break
                case .vertical:
                    self.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                    break
            }
        }) { (complete) -> Void in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
            //如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
            else {
                self.shake(direction: direction, times: times - 1,  interval: interval,
                           delta: delta * -1, completion:completion)
            }
        }
    }
}
