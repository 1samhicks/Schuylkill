//
//  LocationService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Combine
import CoreLocation
import Foundation

public class LocationService: NSObject, DeviceService, CLLocationManagerDelegate {
    
    var lock = RecursiveLock()
    var resultSink = AnyCancellable({})
    var state: ServiceState?
    
    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    override public required init() {
        
    }

    func publishError(error: MyError) {
        
    }

    /*func publishValue(value: MyEvent) {
        servicePublisher.send(input: value)
    }*/

    func start() {
        lock.lock()
        defer { lock.unlock() }
        locationManager!.startUpdatingLocation()
    }

    func pause() {
        lock.lock()
        defer { lock.unlock() }
        locationManager!.stopUpdatingLocation()
    }

    func restart() {
        lock.lock()
        defer { lock.unlock() }
        locationManager!.startUpdatingLocation()
    }

    func terminate() {
        lock.lock()
        defer { lock.unlock() }
        locationManager!.stopUpdatingLocation()
        locationManager = nil
        resultSink.cancel()
    }

    private var locationManager: CLLocationManager?

    init(locationManager loc: CLLocationManager) {
        super.init()
        locationManager = loc
        locationManager!.activityType = CLActivityType.fitness
        locationManager!.allowsBackgroundLocationUpdates = true

        locationManager!.delegate = self
    }

    var serviceState: ServiceState? { get {
        return nil
    } }

    func locationManagerReceivedError(_ error: NSString) {
        self.publishError(error: .LocationError(description: ErrorDescription.empty, suggestion: (error as String)))
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach {
            self.publishValue(value: .locationEvent($0))
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.publishValue(value: .headingEvent(newHeading))
    }

    public func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        true
    }

    #if !os(watchOS)
    public func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
    }

    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.publishValue(value: DeviceEvent.enteredRegion(region))
    }

    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.publishValue(value: DeviceEvent.exitedRegion(region))
    }

    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
    }
    #endif

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.publishError(error: DeviceError.LocationError(description: error.localizedDescription, suggestion: String.empty))
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    }

    #if !os(watchOS)
    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
    }

    public func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
    }

    public func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
    }

    public func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
    }

    public func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
    }
    #endif
}
