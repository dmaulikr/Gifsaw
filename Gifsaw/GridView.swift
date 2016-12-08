//
//  Grid.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-29.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    var difficulty: (Int, Int)!
    
    init(frame: CGRect, difficulty: (Int, Int)) {
        super.init(frame: frame)
        self.difficulty = difficulty
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2)
        context?.setStrokeColor(UIColor.groupTableViewBackground.cgColor)
        
        let width = CGFloat(frame.size.width / CGFloat(difficulty.0))
        let height = CGFloat(frame.size.height / CGFloat(difficulty.1))
        
        // Draw vertical lines
        var i: CGFloat = 0
        repeat {
            context?.move(to: CGPoint(x: 0, y: i))
            context?.addLine(to: CGPoint(x: frame.size.width, y: i))
            context?.strokePath()
            
            i = i + height
            
        } while i <= frame.size.height
        
        // Draw horizontal lines
        var j: CGFloat = 0
        repeat {
            context?.move(to: CGPoint(x: j, y: 0))
            context?.addLine(to: CGPoint(x: j, y: frame.size.height))
            context?.strokePath()
            
            j = j + width
            
        } while j <= frame.size.width
    }
}
