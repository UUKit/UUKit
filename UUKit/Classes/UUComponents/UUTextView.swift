//
//  UUTextView.swift
//  UUKit_Example
//
//  Created by 夏军辉 on 2021/2/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
/*
 @objc(ClassName)
 1、这个是为了在oc中使用，
 2、并且，如果一个在其它module中的类要继承自这个类，可以不写UUKit.UUTextView前面的module名称
 */
@objc(UUTextView)
@IBDesignable
open class UUTextView: UITextView {
    
    // MARK: - Private Properties
    
    private let placeholderView = UITextView(frame: CGRect.zero)
    
    // MARK: - Placeholder Properties
    
    /// This property applies to the entire placeholder string.
    /// The default placeholder color is 70% gray.
    ///
    /// If you want to apply the color to only a portion of the placeholder,
    /// you must create a new attributed string with the desired style information
    /// and assign it to the attributedPlaceholder property.
    @IBInspectable public var placeholderTextColor: UIColor? {
        get {
            return placeholderView.textColor
        }
        set {
            placeholderView.textColor = newValue
        }
    }
    
    /// The string that is displayed when there is no other text in the text view.
    @IBInspectable public var placeholder: String? {
        get {
            return placeholderView.text
        }
        set {
            placeholderView.text = newValue
            setNeedsLayout()
        }
    }
    
    /// This property controls when the placeholder should hide.
    /// Setting it to `true` will hide the placeholder right after the text view
    /// becomes first responder. Setting it to `false` will hide the placeholder
    /// only when the user starts typing in the text view.
    
    /// Default value is `false`
    @IBInspectable public var hidesPlaceholderWhenEditingBegins: Bool = false
    
    /// The styled string that is displayed when there is no other text in the text view.
    public var attributedPlaceholder: NSAttributedString? {
        get {
            return placeholderView.attributedText
        }
        set {
            placeholderView.attributedText = newValue
            setNeedsLayout()
        }
    }
    
    /// Returns true if the placeholder is currently showing.
    public var isShowingPlaceholder: Bool {
        return placeholderView.superview != nil
    }
    
    /// 最大输入数量
    var _maxInputCount = 0
    @IBInspectable public var maxInputCount: Int {
        get {
            return Int(UInt(_maxInputCount))
        }
        set {
            _maxInputCount = Int(UInt(newValue))
        }
    }
    
    // MARK: - Observed Properties

    override open var text: String! {
        didSet {
            showPlaceholderViewIfNeeded()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            showPlaceholderViewIfNeeded()
        }
    }
    
    override open var font: UIFont? {
        didSet {
            placeholderView.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderView.textAlignment = textAlignment
        }
    }
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            placeholderView.textContainerInset = textContainerInset
        }
    }
    
    // MARK: - Initialization
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlaceholderView()
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupPlaceholderView()
    }
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notification
    
    @objc func textDidChange(notification: NSNotification) {
        showPlaceholderViewIfNeeded()
        /*
         这里用的是通知，如果实际使用的地方又设置了文字改变的代理方法，会先执行代理方法的内容，所以这里容易出 bug ，需要在代理方法内再做一次最大长度判断
         */
        // 超出最大输入长度
        if _maxInputCount > 0 , markedTextRange == nil, (text?.count ?? 0) >= _maxInputCount {
            text = text.subString(to: _maxInputCount - 1)
            return
        }
    }
    
    @objc func textViewDidBeginEditing(notification: NSNotification) {
        if hidesPlaceholderWhenEditingBegins && isShowingPlaceholder {
            placeholderView.removeFromSuperview()
            invalidateIntrinsicContentSize()
            setContentOffset(CGPoint.zero, animated: false)
        }
    }
    
    @objc func textViewDidEndEditing(notification: NSNotification) {
        if hidesPlaceholderWhenEditingBegins {
            if !isShowingPlaceholder && (text == nil || text.isEmpty) {
                addSubview(placeholderView)
                invalidateIntrinsicContentSize()
                setContentOffset(CGPoint.zero, animated: false)
            }
        }
    }
    
    // MARK: - UIView
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        resizePlaceholderView()
    }
    
    open override var intrinsicContentSize: CGSize {
        if isShowingPlaceholder {
            return placeholderSize()
        }
        return super.intrinsicContentSize
    }
    
    // MARK: - Placeholder
    
    private func setupPlaceholderView() {
        placeholderView.isOpaque = false
        placeholderView.backgroundColor = UIColor.clear
        placeholderView.textColor = UIColor(white: 0.7, alpha: 1.0)
        
        placeholderView.isEditable = false
        placeholderView.isScrollEnabled = true
        placeholderView.isUserInteractionEnabled = false
        placeholderView.isAccessibilityElement = false
        placeholderView.isSelectable = false
        
        if (placeholder?.count ?? 0) > 0 {
            placeholderView.text = placeholder
        }
        
        if (attributedPlaceholder?.string.count ?? 0) > 0 {
            placeholderView.attributedText = attributedPlaceholder
        }
        
        showPlaceholderViewIfNeeded()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(textDidChange(notification:)), name: UITextView.textDidChangeNotification, object: self)
        notificationCenter.addObserver(self, selector: #selector(textViewDidBeginEditing(notification:)), name: UITextView.textDidBeginEditingNotification, object: self)
        notificationCenter.addObserver(self, selector: #selector(textViewDidEndEditing(notification:)), name: UITextView.textDidEndEditingNotification, object: self)
        //notificationCenter.addObserver(self, selector: #selector(textViewDidEndEditing(notification:)), name: UITextView.textDidEndEditingNotification, object: self)
    }
    
    private func showPlaceholderViewIfNeeded() {
        if !hidesPlaceholderWhenEditingBegins {
            if text != nil && !text.isEmpty {
                if isShowingPlaceholder {
                    placeholderView.removeFromSuperview()
                    invalidateIntrinsicContentSize()
                    setContentOffset(CGPoint.zero, animated: false)
                }
            } else {
                if !isShowingPlaceholder {
                    addSubview(placeholderView)
                    invalidateIntrinsicContentSize()
                    setContentOffset(CGPoint.zero, animated: false)
                }
            }
        }
    }
    
    private func resizePlaceholderView() {
        if isShowingPlaceholder {
            let size = placeholderSize()
            let frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
            
            if !placeholderView.frame.equalTo(frame) {
                placeholderView.frame = frame
                invalidateIntrinsicContentSize()
            }
            
            contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: size.height - contentSize.height, right: 0.0)
        } else {
            contentInset = UIEdgeInsets.zero
        }
    }
    
    private func placeholderSize() -> CGSize {
        var maxSize = self.bounds.size
        maxSize.height = CGFloat.greatestFiniteMagnitude
        return placeholderView.sizeThatFits(maxSize)
    }

}

