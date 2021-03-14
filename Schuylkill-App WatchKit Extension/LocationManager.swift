//
//  LocationManager.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/4/21.
//

import CoreLocation
import Foundation

public class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager?

    init(locationManager loc: CLLocationManager) {
        locationManager = loc
        locationManager!.activityType = CLActivityType.fitness
        locationManager!.allowsBackgroundLocationUpdates = true

        super.init()

        locationManager!.delegate = self
    }

    func beginMonitoring() {
        locationManager!.startUpdatingLocation()
    }

    func endMonitoring() {
    }
}
