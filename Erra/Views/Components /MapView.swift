//
//  MapView.swift
//  Erra
//
//  Created by Heidi Schultz on 9/16/23.
//

import SwiftUI
import MapKit

struct UserAddress: Identifiable {
    var id = UUID()
    var name: String // User's name for the address
    var address: String // User's address as a string
    var coordinate: CLLocationCoordinate2D? // The converted coordinate
}


struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 20.878525, longitude:-156.683746), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        Map(coordinateRegion: $mapRegion)
//        if #available(iOS 17.0, *) {
//            Map()
//        } else {
//            // Fallback on earlier versions
//        }
    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
