//
//  WelcomeViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Foundation
import UIKit
import CoreLocation
import SwiftUI

public struct WelcomeView : UIViewControllerRepresentable {
    
    public func makeUIViewController(context: Context) -> WelcomeViewController {
        return WelcomeViewController()
    }
    
    public func updateUIViewController(_ uiViewController: WelcomeViewController, context: Context) {
        
    }
    
    public typealias UIViewControllerType = WelcomeViewController
    
}

public class WelcomeViewController : UIViewController, CLLocationManagerDelegate {
    var locationManager : CLLocationManager?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()

        view.backgroundColor = .gray
    }
    
    // MARK: - onboarding flow
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
