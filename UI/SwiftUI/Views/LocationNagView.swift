//
//  LocationNagView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import SwiftUI
import UIKit
import Combine

public struct LocationNagView : UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = LocationNagViewController
    
    public func makeUIViewController(context: Context) -> UIViewControllerType {
        LocationNagViewController()
    }
    
    public func updateUIViewController(_ uiViewController: LocationNagViewController, context: Context) {
        
    }
}

struct LocationNagView_Previews: PreviewProvider {
    static var previews: some View {
        LocationNagView()
    }
}
