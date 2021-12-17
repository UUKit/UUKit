//
//  UUReuseIdentifierableProtocol.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/11/26.
//

import UIKit

public protocol UUReuseIdentifierableProtocol {
    static var reuseIdentifier: String { get }
}

extension UUReuseIdentifierableProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: UUReuseIdentifierableProtocol {}
extension UICollectionReusableView: UUReuseIdentifierableProtocol {}
