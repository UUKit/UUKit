//
//  UUSearchController.swift
//  Pods
//
//  Created by uxiu.me on 2019/3/7.
//

import UIKit

open class UUSearchController: UISearchController,UISearchBarDelegate {
    
    public var customSearchBar: UUSearchBar?
    
    public init(searchResultsController: UIViewController, searchBarFrame: CGRect, searchBarFont: UIFont, searchBarTextColor: UIColor, searchBarTintColor: UIColor) {
        super.init(searchResultsController: searchResultsController)
        configureSearchBar(frame: searchBarFrame, font: searchBarFont, textColor: searchBarTextColor, bgColor: searchBarTintColor)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSearchBar(frame: CGRect, font: UIFont, textColor: UIColor, bgColor: UIColor) {
        customSearchBar = UUSearchBar(frame: frame, font: font , textColor: textColor)
        customSearchBar?.showsBookmarkButton = false
        customSearchBar?.showsCancelButton = true
        customSearchBar?.barTintColor = bgColor
        customSearchBar?.tintColor = textColor
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}

//protocol UUSearchControllerProtocol {
//    
//    var searchController: UUSearchController { get }
//    
//}


extension UIViewController:UISearchResultsUpdating {
    
    var searchController: UUSearchController {
        return UUSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44), searchBarFont: UIFont.systemFont(ofSize: 14, weight: .regular), searchBarTextColor: .black, searchBarTintColor: .lightGray)
    }
    
    
    public func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    
}
