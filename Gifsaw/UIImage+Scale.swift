//
//  UIImage+Scale.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-08-20.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    public func scale(to size: CGSize) -> UIImage {
        let cgImage = self.cgImage
        let width = Int(size.width)
        let height = Int(size.height)
        let bitsPerComponent = cgImage?.bitsPerComponent
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent!, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context!.interpolationQuality = CGInterpolationQuality.medium
        context?.draw(cgImage!, in: CGRect(origin: CGPoint.zero, size: CGSize(width: CGFloat(width), height: CGFloat (height))))
        let scaledImage = context?.makeImage().flatMap { UIImage(cgImage: $0) }
        
        return scaledImage!
    }
}
