//
//  HTHomePageView.swift
//  HeadlineOfToday
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2018/1/5.
//  Copyright © 2018年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

protocol HTHomePageViewDelegate: class {
    func pageView(_ pageView: HTHomePageView, targetIndex: Int)
}

class HTHomePageView: UIView {

    weak var homePageDelegate: HTHomePageViewDelegate?
    fileprivate var oldIndex: Int = 0
    fileprivate var currentIndex: Int = 0
    fileprivate var startOffsetX: CGFloat = 0
    
    var titles: [HTHomeTopicTitle]? {
        didSet {
            titleView.titles = titles
        }
    }
    
    var childVcs: [HTHomeTopicViewController]? {
        didSet {
            let vc =  childVcs![currentIndex]
            vc.view.frame = CGRect(x: 0, y: 0, width: collectionView.width, height: collectionView.height)
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate lazy var titleView: HTHomeTitleView = {
        let titleView = HTHomeTitleView()
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight - kNavBarHeight - 40)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HTHomeCollectionViewCell.self, forCellWithReuseIdentifier: "HTHomeCollectionViewCell")
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HTHomePageView {
    
    fileprivate func setupUI() {
        backgroundColor = UIColor.white
        
        addSubview(titleView)
        addSubview(collectionView)
        
        titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(40)
            make.bottom.equalTo(collectionView.snp.top)
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
        }
        homePageDelegate = titleView
    }
}

extension HTHomePageView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HTHomeCollectionViewCell", for: indexPath) as! HTHomeCollectionViewCell
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        let childVc = childVcs![indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// MARK:- UICollectionView的delegate
extension HTHomePageView : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
        scrollView.isScrollEnabled = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        } else {
            scrollView.isScrollEnabled = false
        }
    }
    
    private func contentEndScroll() {
        // 获取滚动到的位置
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.width)
        // 通知titleView进行调整
        homePageDelegate?.pageView(self, targetIndex: currentIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
}

// MARK:- 遵守HYTitleViewDelegate
extension HTHomePageView : HTHomeTitleViewDelegate {
    
    func titleView(_ titleView: HTHomeTitleView, targetIndex: Int) {
        currentIndex = targetIndex
        // 滚动到对应的 index
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
