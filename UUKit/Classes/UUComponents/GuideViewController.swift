//
//  GuideViewController.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/9/3.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

@objcMembers open class GuideViewController: UIViewController {
    
    var guideImgs = [String]()
    
    var firstVC: UIViewController?
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize.zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        config(collectionView)
        return collectionView
    }()
    
    lazy var enterBtn: UIButton = {
        let btn = UIButton()
        btn.alpha = 0
        let btnW = UIScreen.main.bounds.width * 2.0 / 3.0
        let btnH = CGFloat(40.0)
        let btnX = UIScreen.main.bounds.width / 6.0
        let btnY = UIScreen.main.bounds.height * (1 - 1.0/7.0)
        btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        btn.setTitle("立即体验", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 4
        btn.backgroundColor = UIColor(red:0.58, green:0.04, blue:0.14, alpha:1.00)
        btn.addTarget(self, action: #selector(startApp), for: .touchUpInside)
        return btn
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(enterBtn)
        collectionView.register(GuideCollectionViewCell.self, forCellWithReuseIdentifier: "GuideCollectionViewCell")
    }
    
    private func config(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = true
        collectionView.isPagingEnabled = true
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(white: 0.97, alpha: 1)
    }

}

extension GuideViewController {
    
    @objc fileprivate func startApp() {
        UserDefaults.AppStart.set(true, forKey: .isRelaunch)
        if let firstVC = self.firstVC {
            UIApplication.shared.windows[0].rootViewController = firstVC
        } else {
            print("########### Attention: firstVC shouldn't be nil ")
        }
    }
}

extension GuideViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guideImgs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuideCollectionViewCell", for: indexPath) as! GuideCollectionViewCell
        cell.imgv.image = UIImage(named: guideImgs[indexPath.item])
//        if indexPath.item == guideImgs.count - 1 {
//            let gesture = UIPanGestureRecognizer(target: self, action: #selector(startApp))
//            cell.contentView.addGestureRecognizer(gesture)
//        }
        
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let screenW = UIScreen.main.bounds.width
        var alpha: CGFloat = 0
        if offsetX / screenW >= CGFloat(guideImgs.count - 2) {
            alpha = (offsetX - screenW * CGFloat(guideImgs.count - 2)) / screenW
        }
        enterBtn.alpha = alpha
    }
    
}

class GuideCollectionViewCell: UICollectionViewCell {
    
    lazy var imgv: UIImageView = {
        let imgv = UIImageView(frame: UIScreen.main.bounds)
        imgv.contentMode = .scaleAspectFill
        return imgv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(imgv)
    }
}
