//
//  ViewController0.swift
//  ScratchCardImageView
//
//  Created by Aleksandrs Proskurins on 09/12/2016.
//  Copyright © 2016 Aleksandrs Proskurins. All rights reserved.
//

import UIKit

class ViewController0: UIViewController, ScratchCardTouchContainerDelegate {
    
    @IBOutlet weak var scratchCard: UIImageView!
    @IBOutlet var scratchCardTouchContainer: ScratchCardTouchContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scratchCard.image = UIImage(color: UIColor.gray, size: scratchCard.bounds.size)
        
        
        scratchCardTouchContainer.scratchCardImageView = scratchCard
        scratchCardTouchContainer.lineType = .square
        scratchCardTouchContainer.lineWidth = 20
        scratchCardTouchContainer.delegate = self
    }
    
    func scratchCardTouchContainerDidErase(eraseProgress: Float) {
        
        print(eraseProgress)
    }
}
