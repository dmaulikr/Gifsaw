//
//  MediaCell.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-29.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit

class MediaCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: contentView.frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
