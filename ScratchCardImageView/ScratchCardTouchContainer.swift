//
//  ScratchCardTouchContainer.swift
//  ScratchCardImageView
//
//  Created by Aleksandrs Proskurins on 09/12/2016.
//  Copyright © 2016 Aleksandrs Proskurins. All rights reserved.
//

import UIKit

class ScratchCardTouchContainer: UIView {

    private var lastPoint: CGPoint?
    
    var lineType: CGLineCap = .square
    var lineWidth: CGFloat = 20.0
    var scratchCardImageView: UIImageView?
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard  let touch = touches.first, let imageView = scratchCardImageView  else {
            
            return
        }
        
        lastPoint = touch.location(in: imageView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard  let touch = touches.first, let point = lastPoint, let imageView = scratchCardImageView  else {
            
            return
        }
        
        let currentLocation = touch.location(in: imageView)
        
        eraseBetween(fromPoint: point, currentPoint: currentLocation, imageView: imageView)
        
        lastPoint = currentLocation
    }
    
    func eraseBetween(fromPoint: CGPoint, currentPoint: CGPoint, imageView: UIImageView) {
        
        UIGraphicsBeginImageContext(imageView.frame.size)
        
        imageView.image?.draw(in: imageView.bounds)
        
        let path = CGMutablePath()
        path.move(to: fromPoint)
        path.addLine(to: currentPoint)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setShouldAntialias(true)
        context.setLineCap(lineType)
        context.setLineWidth(lineWidth)
        context.setBlendMode(.clear)
        context.addPath(path)
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
}
