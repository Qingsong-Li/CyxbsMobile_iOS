//
//  JWNewsCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by 李青松 on 2023/7/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import Masonry

class JWZXNewsCell: UITableViewCell {
    
    // MARK: Properties
    
    private lazy var timeLab: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(.dm, light: UIColor(hexString: "#294169") ?? .white, dark: UIColor(hexString: "#FFFFFF") ?? .black)
        label.font = UIFont(name: "PingFangSC-Bold", size: 16)
        return label
    }()
    
    private lazy var detailLab: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B") ?? .white, dark: UIColor(hexString: "#FFFFFF") ?? .black)
        label.font = UIFont(name: "PingFangSC-Regular", size: 18)
        return label
    }()
    
    private lazy var seperateLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2))
        view.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#BDCCE5") ?? .black, dark: UIColor(hexString: "#676767") ?? .white)
        return view
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.addSubview(self.timeLab)
        self.addSubview(self.detailLab)
        self.addSubview(self.seperateLine)
        self.laySubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method
    
    func showNews(withTimeString timeStr: String, withDetail detailStr: String) {
        self.timeLab.text = timeStr
        self.detailLab.text = detailStr
    }
    
    private func laySubviews() {
        self.timeLab.mas_makeConstraints { make in
            make?.left.equalTo()(self.mas_left)?.offset()(15)
            make?.top.equalTo()(self.mas_top)?.offset()(11)
        }
        
        self.detailLab.mas_makeConstraints { make in
            make?.left.equalTo()(self.timeLab)
            make?.top.equalTo()(self.timeLab.mas_bottom)?.offset()(11)
            make?.right.lessThanOrEqualTo()(self.mas_right)?.offset()(-15)
        }
    }
}
