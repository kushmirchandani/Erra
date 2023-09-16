//
//  MapView.swift
//  Erra
//
//  Created by Heidi Schultz on 9/16/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct UserAddress: Identifiable {
    var id = UUID()
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D? 

    // Function to geocode the address and update the coordinate
    mutating func geocode() {
        let geocoder = CLGeocoder()
        
        // Capture a local copy of self to avoid the "escaping closure captures mutating 'self' parameter" error
        var localSelf = self
        
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let location = placemarks?.first?.location {
                localSelf.coordinate = location.coordinate
            }
        }
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
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: userAddresses) { address in
            MapMarker(coordinate: address.coordinate!, tint: .blue)
        }
        .onAppear {
            // Geocode the user addresses to obtain coordinates
            for index in userAddresses.indices {
                userAddresses[index].geocode()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
