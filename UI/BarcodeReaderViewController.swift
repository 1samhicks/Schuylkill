//
//  BarcodeReaderViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation

import UIKit
import AVFoundation
import RSBarcodes_Swift
import Resolver

class BarcodeReaderViewController: RSCodeReaderViewController {
    lazy var viewModel = makeViewModel()
    
    @IBOutlet var toggle: UIButton!
    
    @IBAction func switchCamera(_ sender: AnyObject?) {
        let position = self.switchCamera()
        if position == AVCaptureDevice.Position.back {
            print("back camera.")
        } else {
            print("front camera.")
        }
    }
    
    @IBAction func close(_ sender: AnyObject?) {
        print("close called.")
    }
    
    @IBAction func toggle(_ sender: AnyObject?) {
        let isTorchOn = self.toggleTorch()
        print(isTorchOn)
    }
    
    var barcode: String = ""
    var dispatched: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: NOTE: Uncomment the following line to enable crazy mode
        // self.isCrazyMode = true
        
        self.focusMarkLayer.strokeColor = UIColor.red.cgColor
        
        self.cornersLayer.strokeColor = UIColor.yellow.cgColor
        
        self.tapHandler = { point in
            print(point)
        }
        
        // MARK: NOTE: If you want to detect specific barcode types, you should update the types
        let types = self.output.availableMetadataObjectTypes
        // MARK: NOTE: Uncomment the following line remove QRCode scanning capability
        // types = types.filter({ $0 != AVMetadataObject.ObjectType.qr })
          self.output.metadataObjectTypes = types
        
        // MARK: NOTE: If you layout views in storyboard, you should these 3 lines
        for subview in self.view.subviews {
            self.view.bringSubviewToFront(subview)
        }
        
        self.toggle.isEnabled = self.hasTorch()
        
        self.barcodesHandler = { barcodes in
            if !self.dispatched { // triggers for only once
                self.dispatched = true
                for barcode in barcodes {
                    guard let barcodeString = barcode.stringValue else { continue }
                    self.barcode = barcodeString
                    print("Barcode found: type=" + barcode.type.rawValue + " value=" + barcodeString)
                    
                    DispatchQueue.main.async(execute: {
                        self.performSegue(withIdentifier: "nextView", sender: self)
                        
                        // MARK: NOTE: Perform UI related actions here.
                    })
                    
                    // MARK: NOTE: break here to only handle the first barcode object
                    break
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dispatched = false // reset the flag so user can do another scan
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "nextView" && !self.barcode.isEmpty {
            if let destinationVC = segue.destination as? BarcodeDisplayViewController {
                destinationVC.contents = self.barcode
            }
        }
    }
}

extension BarcodeReaderViewController : Resolving {
    func makeViewModel() -> BarcodeReaderViewModel { return resolver.resolve() }
}