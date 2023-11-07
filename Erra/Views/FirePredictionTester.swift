
/*
    The button showcases how the algorithm is supposed to be called

*/
import SwiftUI
import Firebase

struct PercentageChangeView: View {
    @State var percentageChange: Double = 0.0
    @State private var fireLocations: [User2.FireLoc] = []
    @State private var address2: String = ""
    @State private var vector: (dx: Double, dy: Double) = (dx: 0.0, dy: 0.0)

    var body: some View {
        VStack {
            
            Text("Address: \(String(percentageChange))")
        
         

            Button("Calculate Percentage Change") {
                DataManager.shared.fetchAddress1 { address in
                    if let address = address {
                        print("help me ")
                        self.address2 = address
                        
                        let radius = 2.0
                        let user2 = User2(id: UUID(), name: "placeholder", address1: address2)
                        
                        user2.fetchFireLocations { fireLoc1 in
                            
                            user2.fetchFireLocations1 { fireLocations1 in
                                //print(" i love soccer")
                               
                                var circle = user2.isWithinCircle(fireLoc1[0], fireLocations1[0], radius: radius)
                                if circle {
                                    
                                    vector = user2.calculateVector(fireLoc1[0], fireLocations1[0])
                                    //print("tester")
                                }
                                
                                self.percentageChange = user2.calculatePercentageChange(address: address, vector: vector, addressLatitude: fireLocations1[0].latitude, addressLongitude: fireLocations1[0].longitude, radius: radius)
                                
                            }
                            print(percentageChange)
                        }
                        
                    } else {
                        print("im  a failure")
                    }
                }
            }
            .padding()
            
        }
    }
}

struct PercentageChangeView1: PreviewProvider {
    static var previews: some View {
        PercentageChangeView()
    }
}

}

struct PercentageChangeView1: PreviewProvider {
    static var previews: some View {
        PercentageChangeView()
    }
}
