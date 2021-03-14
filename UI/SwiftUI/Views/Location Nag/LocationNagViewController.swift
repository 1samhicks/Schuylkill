//
//  LocationNagViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import SettingsAppAccess
import UIKit

public class LocationNagViewController: UIViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Warning"
        let urlString = SettingsAppLocation.Settings.rawValue
        UIApplication.shared.open(URL(string: urlString)!)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
