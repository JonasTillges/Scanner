//
//  popUpViewController.swift
//  ScannerApp
//
//  Created by Jonas Tillges on 03.03.19.
//  Copyright © 2019 BEANT. All rights reserved.
//

import Foundation

import UIKit




class popUpAlert: UIView, Modal {
   
    
    var backgroundView = UIView()
    var dialogView = UIView()
    
    
    convenience init(title:String,closeButtonText:String,okText:String) {
        self.init(frame: UIScreen.main.bounds)
        initialize(title: title, closeButtonText: closeButtonText, okText: okText)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(title:String, closeButtonText:String, okText:String){
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let dialogViewWidth = frame.width-64
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: dialogViewWidth-16, height: 30))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        dialogView.addSubview(titleLabel)
        
        let separatorLineView = UIView()
        separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 8)
        separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 1)
        separatorLineView.backgroundColor = UIColor.groupTableViewBackground
        dialogView.addSubview(separatorLineView)
        
        
//        let imageView = UIImageView()
//        imageView.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
//        imageView.frame.size = CGSize(width: dialogViewWidth - 16 , height: dialogViewWidth - 16)
//        imageView.image = image
//        imageView.layer.cornerRadius = 4
//        imageView.clipsToBounds = true
//        dialogView.addSubview(imageView)
        
        let dialogViewHeight = titleLabel.frame.height + 8 + separatorLineView.frame.height + 8 
        
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width-64, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
}
