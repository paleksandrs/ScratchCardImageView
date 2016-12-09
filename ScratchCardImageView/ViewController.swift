//
//  ViewController.swift
//  ScratchCardImageView
//
//  Created by Aleksandrs Proskurins on 09/12/2016.
//  Copyright © 2016 Aleksandrs Proskurins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scratchCard: ScratchCardImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scratchCard.image = UIImage(color: UIColor.gray, size: scratchCard.frame.size)
        scratchCard.lineType = .square
        scratchCard.lineWidth = 10
    }
}

