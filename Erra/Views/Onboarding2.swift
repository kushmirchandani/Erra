//
//  Onboarding2.swift
//  Erra
//
//  Created by Heidi Schultz on 8/30/23.
//

import SwiftUI

struct Onboarding2: View {
    @StateObject private var viewModel1 = Login1ViewModel()

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
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.15)
                    .foregroundColor(.white)
                    .cornerRadius(8)
               
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:200, height:200)
                        .position(x:290 ,y: 440)
           
                
                    Text("Let Ignis get to know you!")
                        .font(Font.custom("Inter-Regular",size: 24))
                        .frame(width: UIScreen.main.bounds.width * 0.93)
                        .padding(.top, 60)
                    
            
                //LOGIN LOGIN LOGIN //
                //pls help me position this right
            
                VStack {
                  
                    TextField("Enter Your Email", text: $viewModel1.email)
                        .padding()
                        .background(
                            VStack {
                                Color.white.opacity(0.4)
                                Rectangle().frame(height: 1).foregroundColor(.gray)
                            }
                        )
                                            
                    SecureField("Enter Your Password", text: $viewModel1.password)
                        .padding()
                        .background(
                            VStack {
                                Color.white.opacity(0.4)
                                Rectangle().frame(height: 1).foregroundColor(.gray)
                                    
                            }
                        )
                    Button(action: {
                        viewModel1.signIn()
                    }) {
                        Text("Sign in")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 350)
                .frame(width: UIScreen.main.bounds.width * 0.9)
               
                
                
                
                //bottom stuff
                    
                    HStack (spacing: 130){
                        ZStack(alignment: .leading){
                                           
                            Rectangle()
                        .frame(width: 150, height: 15)
                                .foregroundColor(.gray)
                                .cornerRadius(7)
                            
                            
                            Rectangle()
                            .frame(width:50, height: 15)
                            .foregroundColor(.black)
                            .cornerRadius(7)
                                               
                                       }
                        
                        
                        
                        Image("Arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                        
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height)
                
               
                
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.white)
        }
    }
    }
    struct Onboarding2_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding2()
        }
    }

final class Login1ViewModel : ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found.")
            return
        }
        Task{
            do{
                let returnedUserData: () = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            }catch{
                print("Error: \(error)")
                
            }
        }
    }
}



