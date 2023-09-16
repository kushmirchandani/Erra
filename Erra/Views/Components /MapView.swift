//
//  MapView.swift
//  Erra
//
//  Created by Heidi Schultz on 9/16/23.
//

import SwiftUI
import MapKit
import CoreLocation

class UserAddress: Identifiable {
    var id = UUID()
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D?

    // Function to geocode the address and update the coordinate
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
                        self.coordinate = location.coordinate
                    }

                    completion()
                }
            } else {
                completion()
            }
        }
    }

    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20.878525, longitude: -156.683746),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    // Sample user addresses
    @State private var userAddresses: [UserAddress] = [
        UserAddress(name: "Home", address: "123 Main St, City, Country"),
        UserAddress(name: "Work", address: "456 Elm St, Another City, Another Country")
    ]

    // Filter out addresses without coordinates
    var filteredAddresses: [UserAddress] {
        return userAddresses.filter { $0.coordinate != nil }
    }

    var body: some View {
        Map(coordinateRegion: $mapRegion, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: filteredAddresses) { address in
            MapMarker(coordinate: address.coordinate!, tint: .blue)
        }
        .onAppear {
            // Geocode the user addresses to obtain coordinates
            var geocodeCount = 0 // To keep track of the number of geocoding requests
            for index in userAddresses.indices {
                userAddresses[index].geocode {
                    geocodeCount += 1
                    if geocodeCount == userAddresses.count {
                        // All geocoding requests are completed
                        // Update the map region if needed
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
