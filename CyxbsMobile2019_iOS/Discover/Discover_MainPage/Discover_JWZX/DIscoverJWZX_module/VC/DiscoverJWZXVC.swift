//
//  DiscoverJWZXVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 李青松 on 2023/7/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import FluentDarkModeKit
import Masonry

@objcMembers
class DiscoverJWZXVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    let collectinViewCellID = "collectionViewCell"
    var data = ["1111111","2222222","333333"]
    var width : CGFloat?
    var timer: Timer?
    private lazy var jwNewsBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 0, width: 68, height: self.view.frame.height))
        button.setTitle("教务在线", for: .normal)
        button.setBackgroundImage(UIImage(named: "教务在线背景"), for: .normal)
        button.setTitleColor(UIColor.init(.dm, light: UIColor.white, dark: UIColor.black), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private lazy var textCycleLab: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        let lab = UICollectionView(frame: CGRect(x: 90, y: 0, width: Int(self.width! - 84), height: Int(self.view.frame.height)), collectionViewLayout: layout)
        lab.delegate = self
        lab.dataSource = self
        lab.scrollsToTop = false
        lab.isScrollEnabled = false
        lab.isPagingEnabled = false
        lab.showsVerticalScrollIndicator = false
        lab.backgroundColor = UIColor.red
        lab.register(JWZXNewsCollectionCell.self, forCellWithReuseIdentifier: collectinViewCellID)
        return lab
    }()
    
    @objc
    init(width:CGFloat){
        self.width = width
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let width = self.width{
            self.view.frame = CGRect(x: 0, y: 0, width: width, height: 20)
        }
        self.view.addSubview(self.jwNewsBtn)
        self.view.addSubview(self.textCycleLab)
        addTimer()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.textCycleLab.dequeueReusableCell(withReuseIdentifier: collectinViewCellID, for: indexPath) as! JWZXNewsCollectionCell
        cell.lbl.text = self.data[indexPath.item]
        cell.lbl.textAlignment = .center
        return cell
    }

    // MARK: NSTimer

    func addTimer() {
        removeTimer()
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(beginUpdateUI), userInfo: nil, repeats: true)
    }

    @objc func beginUpdateUI() {
        // 1、当前正在展示的位置
        let currentIndexPath = textCycleLab.indexPathsForVisibleItems.last ?? IndexPath(row: 0, section: 0)
        var nextItem = currentIndexPath.item + 1
        var nextSection = currentIndexPath.section
        
        //如果已经是第二个section的第一个，在正常展示的滚动到第二个之前先无动画滚回第一个section第一个
        if currentIndexPath.section == 1 {
            textCycleLab.scrollToItem(at: IndexPath(item: currentIndexPath.item, section: 0), at: .bottom, animated: false)
            nextSection -= 1
        }
        //当达到第一个section最后一个后，下一次滚动到第二个section第一个
        if nextItem == self.data.count {
            nextItem = 0
            nextSection += 1
        }
        let nextIndexPath = IndexPath(item: nextItem, section: nextSection)
            
        // 3、通过动画滚动到下一个位置
        textCycleLab.scrollToItem(at: nextIndexPath, at: .centeredVertically, animated: true)
        }

        func removeTimer() {
            timer?.invalidate()
            timer = nil
        }
   
}
