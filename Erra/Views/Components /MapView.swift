//
//  MapView.swift
//  Erra
//
//  Created by Heidi Schultz on 9/16/23.
//

import SwiftUI
import MapKit
import CoreLocation
import Firebase
import Foundation

class UserAddress: Identifiable, MapAnnotation1 {
    var id = UUID()
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    
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
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0) // Default coordinate
    }
    
    
    
}


struct CustomAnnotationView: View {
    var title: String

    var body: some View {
        Image("RedCircle")
            .resizable()
            .frame(width: 20, height: 20)
            .scaledToFit()
            .opacity(0.5)
    }
}

//fires calss

class FireLocation: Identifiable, MapAnnotation1 {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    
    // Define the coordinate property here as a stored property
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}


//protocol//////


protocol MapAnnotation1: Identifiable  where ID == UUID{
    var id: UUID { get }
    var coordinate: CLLocationCoordinate2D { get }
    var title: String { get }
}


//conform

extension UserAddress {
    var title: String { return name }
}

extension FireLocation {
    var title: String { return name }
    
}



struct MyMapAnnotation1: Identifiable, MapAnnotation1 {
    var id: UUID
    var coordinate: CLLocationCoordinate2D
    var title: String
}
//map view//////////////////////////////////////


struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20.878525, longitude: -156.683746),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    // Sample user addresses
    @State private var userAddresses: [UserAddress] = []
    @State private var formattedAddress: String?
    @State private var fireLocations: [FireLocation] = []
    
    @State private var myMapAnnotations: [MyMapAnnotation1] = []
    // Filter out addresses without coordinates
    var filteredAddresses: [UserAddress] {
        return userAddresses.filter { $0.coordinate != nil }
    }

    
    
    
    
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: myMapAnnotations) { annotation in
            MapAnnotation(coordinate: annotation.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                CustomAnnotationView(title: annotation.title)
            }
        }

        .onAppear {
            
            
            
            //fetch fire locations
            
            let ref = Database.database().reference().child("fires/-Ni0m_W6vQOdUreW6M2C")
              
              ref.observe(.childAdded, with: { snapshot in
                  if let data = snapshot.value as? [String: Any] {
                      print("PLEASEEEEE")
                      if let latitudeString = data["latitude"] as? String,
                      let longitudeString = data["longitude"] as? String {
                      print("Latitude String: (latitudeString), Longitude String: (longitudeString)")
                      if let latitude = Double(latitudeString),
                      let longitude = Double(longitudeString) {
                      print("Latitude: (latitude), Longitude: (longitude)")

                                      // Create a FireLocation object
                                      let newFireLocation = FireLocation(name: "Fire Location", latitude: latitude, longitude: longitude)

                                      // Create a corresponding MyMapAnnotation
                                      let annotation = MyMapAnnotation1(id: newFireLocation.id, coordinate: newFireLocation.coordinate, title: newFireLocation.title)

                                      // Append the annotation to myMapAnnotations
                                      myMapAnnotations.append(annotation)
                                  }
                              }
                  }
                })
            
            
            
            
            
            // Fetch the formatted address and assign it to the @State property
                     DataManager.shared.fetchAddress1 { fetchedAddress in
                         formattedAddress = fetchedAddress
                         
                         // Append a new UserAddress with the fetched address
                         if let formattedAddress = formattedAddress {
                             let newUserAddress = UserAddress(name: "New Address", address: formattedAddress)
                             userAddresses.append(newUserAddress)
                         }
                     }
            
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
