//
//  BarcodeViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import AVFoundation
import Foundation
import RSBarcodes_Swift
import UIKit

class BarcodeDisplayViewController: UIViewController {
    @IBOutlet private var imageDisplayed: UIImageView!

    var contents: String = "https://github.com/VMwareFusion/nautilus"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = contents
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let gen = RSUnifiedCodeGenerator.shared
        gen.fillColor = UIColor.white
        gen.strokeColor = UIColor.black
        print("generating image with barcode: " + contents)
        if let image = gen.generateCode("Text Example", machineReadableCodeObjectType: AVMetadataObject.ObjectType.qr.rawValue, targetSize: CGSize(width: 1_000, height: 1_000)) {
            debugPrint(image.size)
            self.imageDisplayed.layer.borderWidth = 1
            self.imageDisplayed.image = RSAbstractCodeGenerator.resizeImage(image, targetSize: self.imageDisplayed.bounds.size, contentMode: UIView.ContentMode.bottomRight)
        }
    }
}
