//
//  QRView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/6/21.
//

import SwiftUI
import AVFoundation
import UIKit

struct QRView: View {
    var body: some View {
        ContentView()
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*
private func checkScanPermissions() -> Bool {
  do {
    return try QRCodeReader.supportsMetadataObjectTypes()
  } catch let error as NSError {
    let alert: UIAlertController

    switch error.code {
    case -11852:
      alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)

      alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
        DispatchQueue.main.async {
          if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
          }
        }
      }))

      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    default:
      alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    }

    //present(alert, animated: true, completion: nil)

    return false
  }
}*/


