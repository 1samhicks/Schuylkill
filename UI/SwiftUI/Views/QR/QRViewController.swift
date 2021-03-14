//
//  QRCodeReaderViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import AVFoundation
import Foundation
import QRCodeReader
import Resolver
import SwiftUI
import UIKit

public class QRViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    @LazyInjected var viewModel: QRViewModel

    @IBOutlet var previewView: QRCodeReaderView! {
      didSet {
        previewView.setupComponents(with: QRCodeReaderViewControllerBuilder {
          $0.reader                 = reader
          $0.showTorchButton        = false
          $0.showSwitchCameraButton = false
          $0.showCancelButton       = false
          $0.showOverlayView        = true
          $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        })
      }
    }

    lazy var reader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
      let builder = QRCodeReaderViewControllerBuilder {
        $0.reader                  = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        $0.showTorchButton         = true
        $0.preferredStatusBarStyle = .lightContent
        $0.showOverlayView         = true
        $0.rectOfInterest          = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)

        $0.reader.stopScanningWhenCodeIsFound = false
      }

      return QRCodeReaderViewController(builder: builder)
    }()

    private func checkScanPermissions() -> Bool {
      do {
        return try QRCodeReader.supportsMetadataObjectTypes()
      } catch let error as NSError {
        let alert: UIAlertController

        switch error.code {
        case -11_852:
          alert = UIAlertController(title: "Error",
                                    message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { _ in
            DispatchQueue.main.async {
              if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
              }
            }
          }))

          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        default:
          alert = UIAlertController(title: "Error",
                                    message: "Reader not supported by the current device", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }

        present(alert, animated: true, completion: nil)

        return false
      }
    }

    @IBAction func scanInModalAction(_ sender: AnyObject) {
      guard checkScanPermissions() else { return }

      readerVC.modalPresentationStyle = .formSheet
      readerVC.delegate               = self

      readerVC.completionBlock = { (result: QRCodeReaderResult?) in
        if let result = result {
          print("Completion with result: \(result.value) of type \(result.metadataType)")
        }
      }

      present(readerVC, animated: true, completion: nil)
    }

    @IBAction func scanInPreviewAction(_ sender: Any) {
      guard checkScanPermissions(), !reader.isRunning else { return }

      reader.didFindCode = { result in
        print("Completion with result: \(result.value) of type \(result.metadataType)")
      }

      reader.startScanning()
    }

    // MARK: - QRCodeReader Delegate Methods

    public func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
      reader.stopScanning()
        viewModel.barcode = result.value
/*
      dismiss(animated: true) { [weak self] in
        let alert = UIAlertController(
          title: "QRCodeReader",
          message: String (format:"%@ (of type %@)", result.value, result.metadataType),
          preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self?.present(alert, animated: true, completion: nil)
      }
 */
    }

    public func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
      print("Switching capture to: \(newCaptureDevice.device.localizedName)")
    }

    public func readerDidCancel(_ reader: QRCodeReaderViewController) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }
}

extension QRViewController: Resolving {
    func makeViewModel() -> QRViewModel { return resolver.resolve() }
}
