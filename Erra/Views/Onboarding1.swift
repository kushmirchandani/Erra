//
//  Onboarding1.swift
//  Erra
//
//  Created by Heidi Schultz on 8/30/23.
//


//hiii
import SwiftUI
import FirebaseAuth

struct Onboarding1: View {
    @State private var isOnboarding2Presented = false
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                VStack{
                    Image("onboardFire")
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55)
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
                        .foregroundColor(.white)
                    
                }
                //fix this logo, its static
                Image("Logo")
                    .resizable()
                    .frame(width:200,height:200)
                    .aspectRatio(contentMode: .fit)
                    .position(x:290, y: 560)
                VStack{
                    Text("Meet Ignis. The bridge between safety and security")
                        .font(Font.custom("Inter-Regular",size: 27))
                        .frame(width: UIScreen.main.bounds.width * 0.93, alignment: .top)
                        .padding(.top, 300)
                    
                    Text("Integrate Ingis into your life and protect whats most important.")
                        .font(Font.custom("Inter-Thin",size: 13))
                        .frame(width: UIScreen.main.bounds.width * 0.95, alignment: .top)
                }
                
                    
                    HStack (spacing: 130){
                        
                        Button(action: {
                            isOnboarding2Presented = true
                        }) {
                            Image("Arrow")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                               
                        }
                        .fullScreenCover(isPresented: $isOnboarding2Presented) {
                            Onboarding2()
                        }
                        
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height)
                   
                
                    
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.white)
        }
    }
}

struct Onboarding1_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding1()
    }
}
