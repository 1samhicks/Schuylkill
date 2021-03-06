//
//  LocationNagViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import UIKit
import SettingsAppAccess

public class LocationNagViewController : UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Warning"
        let urlString = SettingsAppLocation.Settings.rawValue
        UIApplication.shared.open(URL(string: urlString)!)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
