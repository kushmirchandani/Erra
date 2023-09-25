//
//  MapViewTester.swift
//  Erra
//
//  Created by Heidi Schultz on 9/25/23.
//

import SwiftUI
import MapKit
import CoreLocation
import AlgorithmMainTester



struct MapViewTester: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20.878525, longitude: -156.683746),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    // Sample user addresses
    @State private var userAddresses: [UserAddress] = [
        UserAddress(name: "Home", address: "123 Main St, City, Country"),
        UserAddress(name: "Work", address: "456 Elm St, Another City, Another Country")
    ]

    // Fire locations received from API calls
    @State private var fireLocations: [CLLocationCoordinate2D] = []

    // Filter out addresses without coordinates
    var filteredAddresses: [UserAddress] {
        return userAddresses.filter { $0.coordinate != nil }
    }

    var body: some View {
        Map(coordinateRegion: $mapRegion, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: filteredAddresses + fireLocations) { location in
            if let address = location as? UserAddress {
                MapPin(coordinate: address.coordinate!, tint: .blue)
            } else if let fireLocation = location as? CLLocationCoordinate2D {
                MapPin(coordinate: fireLocation, tint: .red)
            }
        }
        .onAppear {
            // Geocode the user addresses to obtain coordinates
            var geocodeCount = 0 // To keep track of the number of geocoding requests
            for index in userAddresses.indices {
                userAddresses[index].geocode {
                    geocodeCount += 1
                    if geocodeCount == userAddresses.count {
                        // All geocoding requests are completed
                        // Update the map region to include all user addresses and fire locations
                        if let firstCoordinate = filteredAddresses.first?.coordinate {
                            // Set the map region to include all user addresses and fire locations
                            var maxLatitude = firstCoordinate.latitude
                            var minLatitude = firstCoordinate.latitude
                            var maxLongitude = firstCoordinate.longitude
                            var minLongitude = firstCoordinate.longitude

                            for address in filteredAddresses {
                                let coordinate = address.coordinate!
                                maxLatitude = max(maxLatitude, coordinate.latitude)
                                minLatitude = min(minLatitude, coordinate.latitude)
                                maxLongitude = max(maxLongitude, coordinate.longitude)
                                minLongitude = min(minLongitude, coordinate.longitude)
                            }

                            for fireLocation in fireLocations {
                                maxLatitude = max(maxLatitude, fireLocation.latitude)
                                minLatitude = min(minLatitude, fireLocation.latitude)
                                maxLongitude = max(maxLongitude, fireLocation.longitude)
                                minLongitude = min(minLongitude, fireLocation.longitude)
                            }

                            let centerLatitude = (maxLatitude + minLatitude) / 2
                            let centerLongitude = (maxLongitude + minLongitude) / 2
                            let spanLatitude = maxLatitude - minLatitude
                            let spanLongitude = maxLongitude - minLongitude

                            mapRegion = MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude),
                                span: MKCoordinateSpan(latitudeDelta: spanLatitude, longitudeDelta: spanLongitude)
                            )
                        }
                    }
                }
            }

            // Sample code to add fire locations dynamically (replace with your actual data)
            addFireLocationsFromAPI()
        }
    }

    // Function to add fire locations received from API calls
    func addFireLocationsFromAPI() {
        // Sample API response data
        let apiResponses = [
            "19.40359,-155.28194,335.27,0.54,0.51,2023-09-25,5,1,VIIRS,n,2.0NRT,301.78,9,D",
            // Add more responses as needed
        ]

        for apiResponse in apiResponses {
            let data = apiResponse.split(separator: ",")

            guard data.count >= 2 else {
                continue // Skip invalid data
            }

            let latitude = Double(data[0])!
            let longitude = Double(data[1])!
            fireLocations.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
    }
}
