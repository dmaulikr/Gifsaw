//
//  UIImage+Rotate.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-08-20.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import Foundation
import UIKit

// Find author of this code from StackOverflow

extension UIImage {
    public func rotate(by degrees: CGFloat, flip: Bool?) -> UIImage {
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        bitmap?.rotate(by: degreesToRadians(degrees));
        
        var yFlip = CGFloat(1.0)
        
        if flip == true {
            yFlip = CGFloat(-1.0)
        }

        bitmap?.scaleBy(x: yFlip, y: -1.0)
        bitmap?.draw(cgImage!, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
