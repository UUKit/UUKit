//
//  UUScrollSubviewsProtocol.swift
//  UUKit
//
//  Created by mac on 2020/11/16.
//

import UIKit

public protocol UUReuseableViewProtocol: NSObjectProtocol {}

extension UICollectionView {
    public enum ElementSectionKind {
        case header
        case footer
    }
}

public enum UUSectionViewReuseMode {
    case normal
    case section
}

public enum UUCellReuseMode {
    case normal
    case row
    case item
    case section
    case indexPath
}

// MARK: - Private Func
extension UUReuseableViewProtocol {
    
    private static var className: String {
        return String(describing: self)
    }
    
    private static var bundle: Bundle {
        return Bundle(for: self)
    }
    
    private static var classPath: String? {
        return bundle.path(forResource: className, ofType: "nib")
    }
    
    private static var isNibExist: Bool {
        return classPath != nil
    }
    
    //private static var instance: AnyObject? {
    //    return NSClassFromString(className)?.init()
    //}
    
    private static var nibInstance: Self? {
        return bundle.loadNibNamed(className, owner: self, options: nil)?.first as? Self
    }
    
    private static var nib: UINib? {
        return isNibExist ? UINib(nibName: className, bundle: bundle) : nil
    }
    
    
}

// MARK: - UITableViewCell Setup Funcs
extension UUReuseableViewProtocol where Self: UITableViewHeaderFooterView {
    
    private static func reuseIdentifier(with section: Int, reuseMode: UUSectionViewReuseMode) -> String {
        var classNameStr = ""
        var sectionStr = ""
        switch reuseMode {
        case .normal:
            classNameStr = className
        case .section:
            classNameStr = className
            sectionStr = String(format: "_Section_%003ld", section)
        }
        return classNameStr + sectionStr
    }
    
    private static func register(for container: UITableView, with reuseIdentifier: String) {
        isNibExist ?
            container.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier) :
            container.register(self, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    
}

// MARK: - UITableViewCell Setup Funcs
extension UUReuseableViewProtocol where Self: UITableViewCell {
    
    private static func reuseIdentifier(with indexPath: IndexPath, reuseMode: UUCellReuseMode) -> String {
        var classNameStr = ""
        var sectionStr = ""
        var rowStr = ""
        switch reuseMode {
        case .normal:
            classNameStr = className
        case .row,.item:
            classNameStr = className
            rowStr = String(format: "_Row_%003ld", indexPath.row)
        case .section:
            classNameStr = className
            sectionStr = String(format: "_Section_%003ld", indexPath.section)
        case .indexPath:
            classNameStr = className
            sectionStr = String(format: "_Section_%003ld", indexPath.section)
            rowStr = String(format: "_Row_%003ld", indexPath.row)
        }
        return classNameStr + sectionStr + rowStr
    }
    
    private static func register(for container: UITableView, with reuseIdentifier: String) {
        isNibExist ?
            container.register(nib, forCellReuseIdentifier: reuseIdentifier) :
            container.register(self, forCellReuseIdentifier: reuseIdentifier)
    }
    
}

// MARK: - UICollectionReuseableView Setup Funcs
extension UUReuseableViewProtocol where Self: UICollectionReusableView {
    
    private static func reuseIdentifier(with section: Int, reuseMode: UUSectionViewReuseMode) -> String {
        var classNameStr = ""
        var sectionStr = ""
        switch reuseMode {
        case .normal:
            classNameStr = className
        case .section:
            classNameStr = className
            sectionStr = String(format: "%003ld", section)
        }
        return classNameStr + sectionStr
    }
    
    private static func register(_ sectionViewKind: UICollectionView.ElementSectionKind, for container: UICollectionView, with reuseIdentifier: String) {
        var kind = ""
        switch sectionViewKind {
        case .header:
            kind = UICollectionView.elementKindSectionHeader
        case .footer:
            kind = UICollectionView.elementKindSectionFooter
        }
        isNibExist ?
            container.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier) :
            container.register(self, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
    }
    
}

// MARK: - UICollectionViewCell Setup Funcs
extension UUReuseableViewProtocol where Self: UICollectionViewCell {
    
    private static func reuseIdentifier(with indexPath: IndexPath, reuseMode: UUCellReuseMode) -> String {
        var classNameStr = ""
        var sectionStr = ""
        var itemStr = ""
        switch reuseMode {
        case .normal:
            classNameStr = className
        case .row,.item:
            classNameStr = className
            itemStr = String(format: "_Item_%003ld", indexPath.item)
        case .section:
            classNameStr = className
            sectionStr = String(format: "_Section_%003ld", indexPath.section)
        case .indexPath:
            classNameStr = className
            itemStr = String(format: "_Item_%003ld", indexPath.item)
            sectionStr = String(format: "_Section_%003ld", indexPath.section)
        }
        return classNameStr + sectionStr + itemStr
    }
    
    private static func register(for container: UICollectionView, with reuseIdentifier: String) {
        isNibExist ?
            container.register(nib, forCellWithReuseIdentifier: reuseIdentifier) :
            container.register(self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}


// MARK: - UITableViewHeaderFooterView Public Funcs
extension UUReuseableViewProtocol where Self: UITableViewHeaderFooterView {
    
    public static func newAlways() -> Self {
        return isNibExist ? nibInstance! : Self(reuseIdentifier: className)
    }
    
    public static func setup(in tableView: UITableView, at section: Int, withReuseMode reuseMode: UUSectionViewReuseMode = .normal) -> Self {
        let reuseIdentifier = self.reuseIdentifier(with: section, reuseMode: reuseMode)
        register(for: tableView, with: reuseIdentifier)
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as! Self
    }
    
}

// MARK: - UITableViewCell  Public Funcs
extension UUReuseableViewProtocol where Self: UITableViewCell {
    
    public static func newAlways(_ cellStyle: UITableViewCell.CellStyle = .default) -> Self {
        return isNibExist ? nibInstance! : Self(style: cellStyle, reuseIdentifier: className)
    }
    
    public static func setup(in tableView: UITableView, cellStyle: UITableViewCell.CellStyle = .default) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: className) as? Self else {
            return newAlways(cellStyle)
        }
        return cell
    }
    
    public static func setup(in tableView: UITableView, at indexPath: IndexPath, withReuseMode reuseMode: UUCellReuseMode = .normal) -> Self {
        let reuseIdentifier = self.reuseIdentifier(with: indexPath, reuseMode: reuseMode)
        register(for: tableView, with: reuseIdentifier)
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}

// MARK: - UICollectionReusableView  Public Funcs
extension UUReuseableViewProtocol where Self: UICollectionReusableView {
    
    fileprivate static func setup(_ sectionViewKind: UICollectionView.ElementSectionKind, in collectionView: UICollectionView, at indexPath: IndexPath, withReuseMode reuseMode: UUSectionViewReuseMode = .normal) -> Self {
        var kind = ""
        switch sectionViewKind {
        case .header:
            kind = UICollectionView.elementKindSectionHeader
        case .footer:
            kind = UICollectionView.elementKindSectionFooter
        }
        let reuseIdentifier = self.reuseIdentifier(with: indexPath.section, reuseMode: reuseMode)
        register(sectionViewKind, for: collectionView, with: reuseIdentifier)
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}

// MARK: - UICollectionViewCell Public Funcs
extension UUReuseableViewProtocol where Self: UICollectionViewCell {
    
    public static func setup(in collectionView: UICollectionView, at indexPath: IndexPath, withReuseMode reuseMode: UUCellReuseMode = .normal) -> Self {
        let reuseIdentifier = self.reuseIdentifier(with: indexPath, reuseMode: reuseMode)
        register(for: collectionView, with: reuseIdentifier)
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}

extension UITableViewCell: UUReuseableViewProtocol {}
extension UICollectionReusableView: UUReuseableViewProtocol {}
extension UITableViewHeaderFooterView: UUReuseableViewProtocol {}

