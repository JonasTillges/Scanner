//
//  popUpViewController.swift
//  ScannerApp
//
//  Created by Jonas Tillges on 03.03.19.
//  Copyright © 2019 BEANT. All rights reserved.
//

import UIKit

class popUpViewController: UIViewController {
    
    let popUp = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    
    
    func setupViews() {
        self.view.addSubview(popUp)
        
        let popUpHeight = popUp.height(200)
        let popUpWidth = popUp.width(100)
        
        popUpHeight.constant = 400
        popUpWidth.constant = 200
        UIViewPropertyAnimator(duration: 1, dampingRatio: 0.4) {
            self.popUp.layoutIfNeeded()
            }.startAnimation()
        
        
    }

}
