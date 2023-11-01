//
//  PredictionAlgorithm .swift
//  Erra
//
//  Created by Heidi Schultz on 10/31/23.
//

import Firebase
import CoreLocation
import Foundation
import FirebaseFirestore






extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
}


class User2: ObservableObject {
    var id: UUID
    var name: String
    var address1: String
    @Published var fireLocations1: [FireLocation1] = []
    @Published var fireLocations: [FireLoc] = []
    
    init(id: UUID, name: String, address1: String) {
        self.id = id
        self.name = name
        self.address1 = address1
    }
    
    func geocode(completion: @escaping () -> Void) {
        DataManager.shared.fetchAddress1 { [weak self] formattedAddress in
            guard let self = self else {
                completion()
                return
            }
            
            if let formattedAddress = formattedAddress {
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(formattedAddress) { placemarks, error in
                    if let error = error {
                        print("Geocoding error: \(error.localizedDescription)")
                    }
                    
                    if let location = placemarks?.first?.location {
                        let addressString = formattedAddress
                        self.address1 = addressString 
                    }
                    
                    completion()
                }
            } else {
                completion()
            }
        }
    }
    
    
    
    struct FireLoc {
        var id: String
        var latitude: Double
        var longitude: Double
        var address: String?
    }
    
    struct FireLocation1 {
        var id: String
        var latitude: Double
        var longitude: Double
    }
    
    
    
    
    
    
    // Firebase Data Retrieval
    func fetchFireLocations(completion: @escaping ([FireLoc]) -> Void) {
        let ref = Database.database().reference().child("fires/-Ni0m_W6vQOdUreW6M2C")

        ref.observe(.childAdded, with : { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                if let latitudeString = data["latitude"] as? String,
                   let longitudeString = data["longitude"] as? String {
                    if let latitude = Double(latitudeString),
                       let longitude = Double(longitudeString) {
                        let newFireLocation = FireLoc(id: snapshot.key, latitude: latitude, longitude: longitude)
                        
                        var intermediateArray = self.fireLocations
                        intermediateArray.append(newFireLocation)
                        
                       
                        self.fireLocations = intermediateArray
                        
                        completion([newFireLocation])
                    }
                }
            }
        })
    }

    
    func fetchFireLocations1(completion: @escaping ([FireLocation1]) -> Void) {
        let ref = Database.database().reference().child("fires1/-Ni0mICOREgydlJKk1Xg")

        ref.observe(.childAdded, with: { snapshot in
            if let data = snapshot.value as? [String: Any] {
                if let latitudeString = data["latitude"] as? String,
                   let longitudeString = data["longitude"] as? String {
                    if let latitude = Double(latitudeString),
                       let longitude = Double(longitudeString) {
                        let newFireLocation1 = FireLocation1(id: snapshot.key, latitude: latitude, longitude: longitude)
                        
                        // append new data to intermediate array
                        var intermediateArray = self.fireLocations1
                        intermediateArray.append(newFireLocation1)
                        
                        // replace  main array with  intermediate array
                        self.fireLocations1 = intermediateArray
                        
                        completion([newFireLocation1])
                    }
                }
            }
        })
    }





    
    // Geospatial Calculations
    func isWithinCircle(_ location: FireLoc, _ center: FireLocation1, radius: Double) -> Bool {
        let locationCoordinate = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let centerCoordinate = CLLocation(latitude: center.latitude, longitude: center.longitude)
        
        let distanceInMiles = locationCoordinate.distance(from: centerCoordinate) / 1609.34 // Convert meters to miles
        
        return distanceInMiles <= radius
    }
    
    func calculateVector(_ source: FireLocation1, _ destination: FireLoc) -> (dx: Double, dy: Double) {
        let dx = (destination.longitude - source.longitude).degreesToRadians
        let dy = (destination.latitude - source.latitude).degreesToRadians
        return (dx, dy)
    }
    
    
    func isAddressInCone(address: String, vector: (dx: Double, dy: Double), addressLatitude: Double, addressLongitude: Double) -> Bool {
        let coneHalfAngle = 0.261799
        
        let vectorAngle = atan2(vector.dy, vector.dx)
        
        
        let vectorAngleNormalized = vectorAngle < 0 ? vectorAngle + (2 * .pi) : vectorAngle
        
      
        let addressVectorAngle = atan2(addressLatitude - vector.dy, addressLongitude - vector.dx)
        
        
        let angleDifference = abs(vectorAngleNormalized - addressVectorAngle)
        
       
        return angleDifference <= coneHalfAngle
    }
    
    
    func calculatePercentageChange(address: String, vector: (dx: Double, dy: Double), addressLatitude: Double, addressLongitude: Double, radius: Double) -> Double {
        // Check if the address is within the cone
        let isWithinCone = isAddressInCone(address: address, vector: vector, addressLatitude: addressLatitude, addressLongitude: addressLongitude)
        
        if isWithinCone {

            let distance = sqrt(pow(addressLatitude - vector.1, 2) + pow(addressLongitude - vector.0, 2))


            let percentageChance = (distance / radius) * 100
            
            print((fireLocations[1].latitude, "and", fireLocations[1].longitude))
            return percentageChance
        } else {
            
            return 0.0
        }
    }
}
