//
//  ScratchCardTouchContainer.swift
//  ScratchCardImageView
//
//  Created by Aleksandrs Proskurins on 09/12/2016.
//  Copyright © 2016 Aleksandrs Proskurins. All rights reserved.
//

import UIKit


protocol ScratchCardTouchContainerDelegate: class {
    
    func scratchCardTouchContainerDidErase(eraseProgress: Float)
}

class ScratchCardTouchContainer: UIView {

    private var lastPoint: CGPoint?
    
    var lineType: CGLineCap = .square
    var lineWidth: CGFloat = 20.0
    var scratchCardImageView: UIImageView?
    weak var delegate: ScratchCardTouchContainerDelegate?
    
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
        
        if let img = imageView.image, let _ = delegate {
            let progress = alphaOnlyPersentage(img: img)
            delegate?.scratchCardTouchContainerDidErase(eraseProgress: progress)
        }
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
    
    private func alphaOnlyPersentage(img: UIImage) -> Float {
        
        let width = Int(img.size.width)
        let height = Int(img.size.height)
        
        let bitmapBytesPerRow = width
        let bitmapByteCount = bitmapBytesPerRow * height
        
        let pixelData = UnsafeMutablePointer<UInt8>.allocate(capacity: bitmapByteCount)
        
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        let context = CGContext(data: pixelData,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: bitmapBytesPerRow,
                                space: colorSpace,
                                bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.alphaOnly.rawValue).rawValue)!
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.clear(rect)
        context.draw(img.cgImage!, in: rect)
        
        var alphaOnlyPixels = 0
        
        for x in 0...Int(width) {
            for y in 0...Int(height) {
                
                if pixelData[y * width + x] == 0 {
                    alphaOnlyPixels += 1
                }
            }
        }
        
        free(pixelData)
        
        return Float(alphaOnlyPixels) / Float(bitmapByteCount)
    }
}
