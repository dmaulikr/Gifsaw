//
//  CategoryCell.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-29.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit

class CategoryCell: MediaCell {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let shade = UIView(frame: contentView.bounds)
        shade.backgroundColor = UIColor(white: 0, alpha: 0.15)
        contentView.addSubview(shade)
        
        label = UILabel(frame: contentView.bounds)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.shadowRadius = 0
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.addSubview(label)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
