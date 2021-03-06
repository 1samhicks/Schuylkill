//
//  BarcodeReaderView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation
import SwiftUI
import Resolver
import Combine
import UIKit

struct BarcodeReaderView : UIViewControllerRepresentable {
    
    var barcodeReaderViewController : UIViewController!
    
    func performOnAppear() {
        
    }
    
    init() {
    }
    
    public func makeUIViewController(context: Context) -> BarcodeReaderViewController {
        return BarcodeReaderViewController()
    }
    
    public func updateUIViewController(_ uiViewController: BarcodeReaderViewController, context: Context) {
        
    }
    
    public typealias UIViewControllerType = BarcodeReaderViewController
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            BarcodeReaderView()
        }
    }

}

