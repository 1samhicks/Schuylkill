//
//  LocationService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Combine
import CoreLocation
import Foundation

 class LocationService: NSObject, DeviceService, CLLocationManagerDelegate {
    var servicePublisher: DeviceServicePublisher
    
    var lock = RecursiveLock()
    var resultSink = AnyCancellable({})
    var state: ServiceState?
    typealias MyPublisher = DeviceServicePublisher
    typealias MyEvent = DeviceEvent
    typealias MyError = DeviceError
    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    override  required init() {
        servicePublisher = DeviceServicePublisher.shared
        super.init()
        locationManager.delegate = self
    }

    /*func publishError(error: MyError) {
        servicePublisher.send(error: error)
    }

    func publishValue(value: MyEvent) {
        servicePublisher.send(input: value)
    }*/

    func start() {
        lock.lock(); defer { lock.unlock() }
        locationManager.startUpdatingLocation()
    }

    func pause() {
        lock.lock(); defer { lock.unlock() }
        locationManager.stopUpdatingLocation()
    }

    func restart() {
        lock.lock(); defer { lock.unlock() }
        locationManager.startUpdatingLocation()
    }

    func terminate() {
        lock.lock(); defer { lock.unlock() }
        locationManager.stopUpdatingLocation()
        resultSink.cancel()
    }

    private var locationManager = CLLocationManager()
    init(locationManager loc: CLLocationManager) {
        servicePublisher = DeviceServicePublisher.shared
        locationManager = loc
        locationManager.activityType = CLActivityType.fitness
        locationManager.allowsBackgroundLocationUpdates = true
        super.init()
        locationManager.delegate = self
    }

    var serviceState: ServiceState? {
            return nil
    }

    func locationManagerReceivedError(_ error: NSString) {
        self.publishError(error: .LocationError(description: "", suggestion: (error as String)))
    }

     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach {
            self.publishValue(value: .locationEvent($0))
        }
    }

     func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.publishValue(value: .headingEvent(newHeading))
    }

     func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        true
    }

    #if !os(watchOS)
     func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState,
                                for region: CLRegion) {
    }

     func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.publishValue(value: DeviceEvent.enteredRegion(region))
    }

     func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.publishValue(value: DeviceEvent.exitedRegion(region))
    }

     func locationManager(_ manager: CLLocationManager,
                                monitoringDidFailFor region: CLRegion?,
                                withError error: Error) {
        
    }
    #endif

     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.publishError(error: DeviceError.LocationError(description: error.localizedDescription,
                                                           suggestion: String.empty))
     }

     func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
    }

     func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    }

    #if !os(watchOS)
     func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
    }

     func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
    }

     func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
    }

     func locationManager(_ manager: CLLocationManager,
                                didFinishDeferredUpdatesWithError error: Error?) {
    }

     func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
    }
    #endif
}
