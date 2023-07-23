//
//  JWZXNewsCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by 李青松 on 2023/7/23.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class JWZXNewsCollectionCell: UICollectionViewCell {
    var lbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpChildControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpChildControl()
    }
    
    private func setUpChildControl() {
        let lbl = UILabel()
        addSubview(lbl)
        lbl.frame = bounds
        
        self.lbl = lbl
    }
}
