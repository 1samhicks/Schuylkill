//
//  LocationService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreLocation
import Combine

public class LocationService : DeviceService, CLLocationManagerDelegate {
    
    var dispatchSemaphore: DispatchSemaphore = DispatchSemaphore(value:1)
    
    var resultSink: AnyCancellable = AnyCancellable({})
    func startService() {
        locationManager!.startUpdatingLocation()
    }
    
    func pauseService() {
         
    }
    
    func unpauseService() {
        
    }
    
    func endService() {
        locationManager!.stopUpdatingLocation()
        locationManager = nil
        resultSink.cancel()
    }
    
    required public override init() {
        
    }
    
    
    private var locationManager : CLLocationManager?
    
    init(locationManager loc: CLLocationManager) {
        locationManager = loc
        locationManager!.activityType = CLActivityType.fitness
        locationManager!.allowsBackgroundLocationUpdates = true
        
        super.init()
        
        locationManager!.delegate = self
    }
    
    var serviceState : ServiceState? { get {
        return nil
    } }
    
    
    func locationManagerReceivedError(_ error:NSString) {
        self.publishError(error: DeviceError.LocationError(description: nil,suggestion: (error as String)))
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach {
            self.publishValue(value: DeviceEvent.locationEvent($0))
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.publishValue(value: DeviceEvent.headingEvent(newHeading))
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
    #endif
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.publishError(error: DeviceError.LocationError(description: error.localizedDescription, suggestion: nil))
    }


    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        
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