//
//  ExerciseMachine.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import Foundation
import CoreLocation
import Resolver

struct CDExerciseMachine: Codable {
    
    var id : UUID!
    
    enum CodingKeys: String, CodingKey {
        case id = "identifier"
        case lat = "lat"
        case long = "long"
        case title = "title"
        case userId = "user_id"
    }
    
    var location : CLLocation?
    var title: String
    //@ServerTimestamp var createdTime: Timestamp?
    var userId: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID(uuidString: try container.decode(String.self, forKey: .id))
        self.title = try container.decode(String.self, forKey: .title)
        
        let lat = try container.decode(CLLocationDegrees.self, forKey: .lat)
        let long = try container.decode(CLLocationDegrees.self, forKey: .long)
        
        location = CLLocation(latitude: lat, longitude: long)
    }

    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id.uuidString, forKey: .id)
            try container.encode(location?.coordinate.latitude, forKey: .lat)
            try container.encode(location?.coordinate.longitude, forKey: .long)
            try container.encode(title, forKey: .title)
    }
    
    mutating func decode(to decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID(uuidString: try container.decode(String.self, forKey: .id))
        self.title = try container.decode(String.self, forKey: .title)
        
        let lat = try container.decode(CLLocationDegrees.self, forKey: .lat)
        let long = try container.decode(CLLocationDegrees.self, forKey: .long)
        
        location = CLLocation(latitude: lat, longitude: long)
        
    }
    func hasAssignedLocation() -> Bool {
        return !(location==nil)
    }
    
    func isMachineBeingUsed() -> Bool {
        return (self.id==AppData.current_machine.id)
    }
}

extension CDExerciseMachine {
    
    func setMachineBeingUsed() {
        AppData.current_machine = self
    }
    
    public mutating func inRegion(currentLocation : CLLocation) -> Bool {
        if(hasAssignedLocation()) {
            let distance = currentLocation.distance(from: CLLocation(latitude: location!.coordinate.latitude,
                longitude: location!.coordinate.longitude))
            return (distance <= AppData.machine_region_distance)
        }
        else {
            return false
        }
    }
    
    /*
     This only needs to be called once per machine
     */
    static func addMachine(withName: String, forMuscles: Set<CDMuscle>, atLocation: CLLocation) {
        
    }
}
