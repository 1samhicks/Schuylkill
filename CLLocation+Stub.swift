//
//  CLLocation+Stub.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/19/21.
//

import Foundation
import CoreLocation
import SwifterSwift

extension String {
    
    func dictionary() throws -> [String:(String,String)] {
            // make sure this JSON is in the format we expect
        try JSONSerialization.jsonObject(with: Data(self.utf8), options: []) as! [String:(String,String)]
    }
}

extension CLLocation {
    
    public static func sample() throws -> CLLocation {
        do {
            let loc1 = try samples()
            let loc2 = try samples()
            
            return CLLocation(latitude: 0,longitude: 0)
            //return (loc1?.midLocation(to: loc2))!
        } catch let e {
            throw ApplicationRuntimeError(errorDescription: "Problem in the JSON source for location sample data", recoverySuggestion: "Look closely at the JSON",error: e)
        }
    }
    
    public static func samples() throws -> Any? {
        try """
                [
                {
                "state":"Alaska",
                "latitude":61.3850,
                "longitude":-152.2683
                },
                {
                "state":"Alabama",
                "latitude":32.7990,
                "longitude":-86.8073
                },
                {
                "state":"Arkansas",
                "latitude":34.9513,
                "longitude":-92.3809
                },
                {
                "state":"Arizona",
                "latitude":33.7712,
                "longitude":-111.3877
                },
                {
                "state":"California",
                "latitude":36.1700,
                "longitude":-119.7462
                },
                {
                "state":"Colorado",
                "latitude":39.0646,
                "longitude":-105.3272
                },
                {
                "state":"Connecticut",
                "latitude":41.5834,
                "longitude":-72.7622
                },
                {
                "state":"Delaware",
                "latitude":39.3498,
                "longitude":-75.5148
                },
                {
                "state":"Florida",
                "latitude":27.8333,
                "longitude":-81.7170
                },
                {
                "state":"Georgia",
                "latitude":32.9866,
                "longitude":-83.6487
                },
                {
                "state":"Hawaii",
                "latitude":21.1098,
                "longitude":-157.5311
                },
                {
                "state":"Iowa",
                "latitude":42.0046,
                "longitude":-93.2140
                },
                {
                "state":"Idaho",
                "latitude":44.2394,
                "longitude":-114.5103
                },
                {
                "state":"Illinois",
                "latitude":40.3363,
                "longitude":-89.0022
                },
                {
                "state":"Indiana",
                "latitude":39.8647,
                "longitude":-86.2604
                },
                {
                "state":"Kansas",
                "latitude":38.5111,
                "longitude":-96.8005
                },
                {
                "state":"Kentucky",
                "latitude":37.6690,
                "longitude":-84.6514
                },
                {
                "state":"Louisiana",
                "latitude":31.1801,
                "longitude":-91.8749
                },
                {
                "state":"Massachusetts",
                "latitude":42.2373,
                "longitude":-71.5314
                }
            ]
            """
    }
}
