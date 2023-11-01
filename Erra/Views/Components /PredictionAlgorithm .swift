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


class User {
    var id: String
    var name: String
    var address1: String
    
    init(id: String, name: String, address1: String) {
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
                        self.address1 = addressString // Update the mutable property
                    }

                    completion()
                }
            } else {
                completion()
            }
        }
    }
}


struct FireLoc {
    var id: String
    var name: String
    var latitude: Double
    var longitude: Double
    var address: String?
}

struct FireLocation1 {
    var id: String
    var latitude: Double
    var longitude: Double
}




extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
}

// Firebase Data Retrieval
func fetchFireLocations(completion: @escaping ([FireLoc]) -> Void) {
    let ref = Database.database().reference().child("fires/-Ni0m_W6vQOdUreW6M2C")

    ref.observeSingleEvent(of: .value) { (snapshot) in
        guard let data = snapshot.value as? [String: Any] else {
            completion([])
            return
        }

        var fireLocations = data.compactMap { (key, value) in
            if let locationData = value as? [String: Any],
               let name = locationData["name"] as? String,
               let latitude = locationData["latitude"] as? Double,
               let longitude = locationData["longitude"] as? Double {
                return FireLoc(id: key, name: name, latitude: latitude, longitude: longitude, address: nil)
            }
            return nil
        }

        // Fetch user addresses and associate them with the corresponding FireLoc objects
        fetchUserAddresses(for: fireLocations) { usersWithAddresses in
            for (index, user) in usersWithAddresses.enumerated() {
                fireLocations[index].address = user.address1
            }

            completion(fireLocations)
        }
    }
}

func fetchFireLocations1(completion: @escaping ([FireLocation1]) -> Void) {
    let ref = Database.database().reference().child("fires1/-Ni0mICOREgydlJKk1Xg")

    ref.observeSingleEvent(of: .value) { (snapshot) in
        guard let data = snapshot.value as? [String: Any] else {
            completion([])
            return
        }

        let fireLocations1 = data.compactMap { (key, value) in
            if let locationData = value as? [String: Any],
               let latitude = locationData["latitude"] as? Double,
               let longitude = locationData["longitude"] as? Double {
                return FireLocation1(id: key, latitude: latitude, longitude: longitude)
            }
            return nil
        }
        completion(fireLocations1)
    }
}

// Fetch user addresses from Firestore
func fetchUserAddresses(for fireLocations: [FireLoc], completion: @escaping ([User]) -> Void) {
    let db = Firestore.firestore()
    let usersRef = db.collection("Users")

    let userIDs = fireLocations.map { $0.id }

    usersRef.whereField("id", in: userIDs).getDocuments { (snapshot, error) in
        guard error == nil else {
            print(error!.localizedDescription)
            completion([])
            return
        }

        if let snapshot = snapshot {
            let users = snapshot.documents.compactMap { document -> User? in
                let data = document.data()
                if let id = data["id"] as? String,
                   let name = data["name"] as? String,
                   let address1 = data["address1"] as? String {
                    return User(id: id, name: name, address1: address1)
                }
                return nil
            }
            completion(users)
        } else {
            completion([])
        }
    }
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
    
    // Calculate the angle of the vector using atan2
    let vectorAngle = atan2(vector.dy, vector.dx)

    // You may need to convert vectorAngle to the [0, 2π) range depending on your coordinate system
    // Vector angle is typically in the range (-π, π]. You can convert it to [0, 2π) by adding 2π to negative values.
    let vectorAngleNormalized = vectorAngle < 0 ? vectorAngle + (2 * .pi) : vectorAngle

    // Now, calculate the angle between the vector and the address's location
    let addressVectorAngle = atan2(addressLatitude - vector.dy, addressLongitude - vector.dx)

    // Calculate the absolute difference between the vector angle and the address angle
    let angleDifference = abs(vectorAngleNormalized - addressVectorAngle)

    // Check if the address falls within the cone's angle range
    return angleDifference <= coneHalfAngle
}


