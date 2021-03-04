//
//  LocationService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreLocation
import Combine

public class LocationService : NSObject, DeviceService, CLLocationManagerDelegate {
    var resultSink: AnyCancellable = AnyCancellable({})
    func startService() {
        
    }
    
    func pauseService() {
         
    }
    
    func endService() {
        
    }
    
    required public override init() {
        
    }
    
    var servicePublisher: ServicePublisher {
        DeviceServicePublisher.shared!
    }
    
    public func cancel() {
        endMonitoring()
        locationManager = nil
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
    
    func beginMonitoring() {
        locationManager!.startUpdatingLocation()
    }
    
    func endMonitoring() {
        locationManager!.stopUpdatingLocation()
    }
    
    func locationManagerReceivedError(_ error:NSString) {
      print(error)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
    }
    
    public func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        true
    }
    
    #if !os(watchOS)
    public func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
    }
    #endif
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
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
