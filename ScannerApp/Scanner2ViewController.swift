//
//  Scanner2ViewController.swift
//  ScannerApp
//
//  Created by Jonas Tillges on 02.03.19.
//  Copyright © 2019 BEANT. All rights reserved.
//

import UIKit
import WeScan
import TinyConstraints

class Scanner2ViewController: UIViewController, ImageScannerControllerDelegate {
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scannerViewController = ImageScannerController()
        scannerViewController.imageScannerDelegate = self
        present(scannerViewController, animated: true)
        setupView()
    }
    
    
    func setupView(){
        
        self.view.addSubview(imageView)
        
        imageView.edgesToSuperview(insets: .top(10) + .left(10))
        
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        // You are responsible for carefully handling the error
        print(error)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        // The user successfully scanned an image, which is available in the ImageScannerResults
        if results.doesUserPreferEnhancedImage {
            imageView.image = results.enhancedImage
        }else{
            imageView.image = results.scannedImage
        }
        
        // You are responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true)
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        // The user tapped 'Cancel' on the scanner
        // You are responsible for dismissing the ImageScannerController
        navigationController?.popViewController(animated: true)
        scanner.dismiss(animated: true)
    }
    


}
