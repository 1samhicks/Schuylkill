//
//  BarcodeDisplayView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation

import SwiftUI
import Resolver
import Combine
import UIKit

struct BarcodeDisplayView: UIViewControllerRepresentable {
    var barcodeDisplayViewController: UIViewController!

    func performOnAppear() {

    }

    init() {
    }

    public func makeUIViewController(context: Context) -> BarcodeDisplayViewController {
        return BarcodeDisplayViewController()
    }

    public func updateUIViewController(_ uiViewController: BarcodeDisplayViewController, context: Context) {

    }

    public typealias UIViewControllerType = BarcodeDisplayViewController

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            BarcodeDisplayView()
        }
    }

}
