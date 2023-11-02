
import SwiftUI
import Firebase

struct PercentageChangeView: View {
    @State var percentageChange: Double = 0.0
    @State private var fireLocations: [User2.FireLoc] = []
    @State private var address2: String = ""


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
                                
                                
                               
                                let vector = user2.calculateVector(fireLocations1[0], fireLoc1[0])
                                //print("tester")
                            
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
