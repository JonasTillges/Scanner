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
import PDFKit

class Scanner2ViewController: UIViewController, ImageScannerControllerDelegate {
    
    let imageView = UIImageView()
    var image = UIImage()
    let shareButton = UIButton(type: .system)
    var url = URL(fileURLWithPath: "/Path/To/PDF")
    override func viewDidLoad() {
        super.viewDidLoad()

        let scannerViewController = ImageScannerController()
        scannerViewController.imageScannerDelegate = self
        present(scannerViewController, animated: true)
        setupView()
    }
    
    
    func setupView(){
        self.view.addSubview(imageView)
        self.view.addSubview(shareButton)
        imageView.contentMode = .scaleAspectFill
        imageView.edgesToSuperview(insets: .top(10) + .left(10))
        
        shareButton.setTitle("Share PDF", for: .normal)
        shareButton.tintColor = .white
        shareButton.backgroundColor = UIColor(red: 11/255, green: 22/255, blue: 53/255, alpha: 1)
        shareButton.layer.cornerRadius = 10
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        shareButton.center(in: view, offset: CGPoint(x: 0, y: 50))
        shareButton.height(50)
        shareButton.width(100)
        shareButton.isHidden = true
    }
    @objc func shareButtonTapped(){

        UIViewPropertyAnimator(duration: 1, dampingRatio: 0.4) {
            self.shareButton.layoutIfNeeded()
            }.startAnimation()
        sharePdf(path: url)
    }
    
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        // You are responsible for carefully handling the error
        print(error)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        // The user successfully scanned an image, which is available in the ImageScannerResults
        if results.doesUserPreferEnhancedImage {
            image = results.enhancedImage!
            imageView.image = results.enhancedImage
        }else{
            image = results.scannedImage
            imageView.image = results.scannedImage
        }
        shareButton.isHidden = false
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let docURL = documentDirectory.appendingPathComponent("myFile.pdf")
        url = docURL
        try createPDF(image: image)?.write(to: docURL, atomically: true)
        
        // You are responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true)
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        // The user tapped 'Cancel' on the scanner
        // You are responsible for dismissing the ImageScannerController
        navigationController?.popViewController(animated: true)
        scanner.dismiss(animated: true)
    }
    
    func loadPDFAndShare(){
        print(url)
        let fileManager = FileManager.default
        let documentoPath = url.absoluteString
        print(documentoPath)
        
        if fileManager.fileExists(atPath: documentoPath){
            let documento = NSData(contentsOfFile: documentoPath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
        }
    }
    
    func sharePdf(path:URL) {
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: path.path) {
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [path], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        } else {
            print("document was not found")
            let alertController = UIAlertController(title: "Error", message: "Document was not found!", preferredStyle: .alert)
            let defaultAction = UIAlertAction.init(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    func createPDF(image: UIImage) -> NSData? {
        
        let pdfData = NSMutableData()
        let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!
        
        var mediaBox = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(image.cgImage!, in: mediaBox)
        pdfContext.endPage()
        
        return pdfData
    }


}
