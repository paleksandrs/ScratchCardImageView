//
//  ScratchCardImageView.swift
//  ScratchCardImageView
//
//  Created by Aleksandrs Proskurins on 09/12/2016.
//  Copyright © 2016 Aleksandrs Proskurins. All rights reserved.
//

import UIKit


class ScratchCardImageView: UIImageView {

    private var lastPoint: CGPoint?
    
    var lineType: CGLineCap = .square
    var lineWidth: CGFloat = 20.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        guard  let touch = touches.first else {
            
            return
        }
 
        lastPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard  let touch = touches.first, let point = lastPoint else {
            
            return
        }
        
        let currentLocation = touch.location(in: self)
        eraseBetween(fromPoint: point, currentPoint: currentLocation)
        
        lastPoint = currentLocation
    }
    
    func eraseBetween(fromPoint: CGPoint, currentPoint: CGPoint) {
    
        UIGraphicsBeginImageContext(self.frame.size)
        
        image?.draw(in: self.bounds)
        
        let path = CGMutablePath()
        path.move(to: fromPoint)
        path.addLine(to: currentPoint)
        
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.setShouldAntialias(true)
        context.setLineCap(lineType)
        context.setLineWidth(lineWidth)
        context.setBlendMode(.clear)
        context.addPath(path)
        context.strokePath()
        
        image = UIGraphicsGetImageFromCurrentImageContext()
    
        context.restoreGState()
        
        UIGraphicsEndImageContext()
    }
}
