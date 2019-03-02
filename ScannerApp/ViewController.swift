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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 44/255, green: 57/255, blue: 95/255, alpha: 1)
        navigationItem.title = "programmaticallyUI"
        navigationController?.navigationBar.barTintColor = UIColor(red: 217/255, green: 48/255, blue: 80/255, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        setupViews()
        
    }
    
    
    func setupViews() {
        let buttonX = 150
        let buttonY = 150
        let buttonWidth = 100
        let buttonHeight = 50
        let button = UIButton(type: .system)
        button.setTitle("Scan", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        self.view.addSubview(button)
        
        let scanbuttonX = 150
        let scanbuttonY = 500
        let scanbuttonWidth = 100
        let scanbuttonHeight = 50
        let scanButton = UIButton(type: .system)
        scanButton.setTitle("Scan", for: .normal)
        scanButton.tintColor = .white
        scanButton.backgroundColor = .red
        scanButton.addTarget(self, action: #selector(scanbuttonClicked), for: .touchUpInside)
        scanButton.frame = CGRect(x: scanbuttonX, y: scanbuttonY, width: scanbuttonWidth, height: scanbuttonHeight)
        self.view.addSubview(scanButton)
        
    }
    
    @objc func buttonClicked() {
        
        let scanner = ScannerViewController()
        
        scanner.delegate = self
        navigationController?.pushViewController(scanner, animated: true)
    }
    
    @objc func scanbuttonClicked (){
        let scanner = Scanner2ViewController()
        navigationController?.pushViewController(scanner, animated: true)
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


