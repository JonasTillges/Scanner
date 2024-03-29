//
//  ViewController.swift
//  ScannerApp
//
//  Created by Jonas Tillges on 02.03.19.
//  Copyright © 2019 BEANT. All rights reserved.
//

import UIKit
import YesWeScan
import TinyConstraints


class ViewController: UIViewController {
    
    var scannedImage: UIImage?
    let scanButton = UIButton(type: .system)
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 44/255, green: 57/255, blue: 95/255, alpha: 1)
        navigationItem.title = "Scanner App"
        navigationController?.navigationBar.barTintColor = UIColor(red: 217/255, green: 48/255, blue: 80/255, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupViews()
    }
    
    
    func setupViews() {
        self.view.addSubview(scanButton)
        self.view.addSubview(button)
    
        button.setTitle("popUp", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 11/255, green: 22/255, blue: 53/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.center(in: view, offset: CGPoint(x: 0, y: 50))
        button.height(50)
        button.width(100)
        //button.isHidden = true
        scanButton.setTitle("Scan", for: .normal)
        scanButton.tintColor = .white
        scanButton.backgroundColor = UIColor(red: 11/255, green: 22/255, blue: 53/255, alpha: 1)
        scanButton.layer.cornerRadius = 10
        scanButton.addTarget(self, action: #selector(scanbuttonClicked), for: .touchUpInside)
        scanButton.center(in: view, offset: CGPoint(x: 0, y: -50))
        let height = scanButton.height(50)
        let width = scanButton.width(100)
        
        height.constant = 100
        width.constant = 150
        UIViewPropertyAnimator(duration: 1.5, dampingRatio: 0.2) {
            self.scanButton.layoutIfNeeded()
            }.startAnimation()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let height = scanButton.height(50)
        let width = scanButton.width(100)
        
        height.constant = 100
        width.constant = 150
        UIViewPropertyAnimator(duration: 1.5, dampingRatio: 0.2) {
            self.scanButton.layoutIfNeeded()
            }.startAnimation()
    }
    
    @objc func buttonClicked() {
        
        let alert = popUpAlert(title: "Install our new App.", closeButtonText: "No, Thanks", okText: "yes")
        alert.show(animated: true)
        
//        let scanner = ScannerViewController()
//        scanner.navigationItem.title = "Scanner"
//        scanner.delegate = self
//
//        navigationController?.pushViewController(scanner, animated: true)
    }
    
    @objc func scanbuttonClicked (){
        let scanner = Scanner2ViewController()
        scanner.navigationItem.title = "Scanner"
        navigationController?.pushViewController(scanner, animated: false)
    }
    
}


extension ViewController: ScannerViewControllerDelegate {
    func scanner(_ scanner: ScannerViewController, didCaptureImage image: UIImage) {
        scannedImage = image
        navigationController?.popViewController(animated: true)
    }
    
    
    func didCapture(image: UIImage) {
        scannedImage = image
        navigationController?.popViewController(animated: true)
    }
}


