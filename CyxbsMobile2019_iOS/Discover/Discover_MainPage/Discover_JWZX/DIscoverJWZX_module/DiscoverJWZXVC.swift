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
class DiscoverJWZXVC: UIViewController {
    var width : CGFloat?
    private lazy var jwNewsBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 0, width: 68, height: self.view.frame.height))
        button.setTitle("教务在线", for: .normal)
        button.setBackgroundImage(UIImage(named: "教务在线背景"), for: .normal)
        button.setTitleColor(UIColor.init(.dm, light: UIColor.white, dark: UIColor.black), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private lazy var jwNewsTextLab: UILabel = {
        let lab = UILabel(frame: CGRect(x: 90, y: 0, width: Int(self.width! - 84), height: Int(self.view.frame.height)))
        lab.text = "教务在线新闻正在请求中..."
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.init(.dm, light: UIColor.black, dark: UIColor.white)
        lab.backgroundColor = .clear
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
        self.view.addSubview(self.jwNewsTextLab)
        
    }


   
}
