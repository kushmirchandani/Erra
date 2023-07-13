//
//  LoginView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/8/23.
//

import SwiftUI
@MainActor
final class LoginViewModel : ObservableObject{
    
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
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    var body: some View {
        
        
        ZStack {
            
            
            Color.white.opacity(1) // Lower opacity of the grey background
            
            VStack(spacing: 20) { // Adjust spacing between the login rectangles
                Spacer()
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(#colorLiteral(red: 0.9125000238418579, green: 0.9125000238418579, blue: 0.9125000238418579, alpha: 0.2))) // Adjusted opacity of the grey rectangle
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .overlay(
                        
                
                        VStack {
                            Text("Welcome to Erra")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Test Prep Simplified")
                            
                           
                            //apple button
                            VStack(spacing: 20) {
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "applelogo")
                                            .resizable()
                                            .frame(width: 20, height: 25)
                                        Text("Apple Sign In")
                                            .padding(5)
                                    }
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(10)
                                    .background(Color.black)
                                    .cornerRadius(10)
                                }
                                //google button
                                Button(action: {}) {
                                    HStack {
                                        Image("Google Icon White")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("Google Sign In")
                                            .padding(5)
                                    }
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(10)
                                    .background(Color.black)
                                    .cornerRadius(10)
                                }
                                
                                Text("or")
                                    .padding(10)
                                
                                //Sign in with email
                                VStack{
                                    TextField("Email...", text: $viewModel.email)
                                        .background(Color.white.opacity(0.4))
                                        .cornerRadius(10)
                                        .padding()
                                    
                                    SecureField("Password...", text: $viewModel.password)
                                        .background(Color.white.opacity(0.4))
                                        .cornerRadius(10)
                                        .padding()
                                }
                                Button {
                                    viewModel.signIn()
                                } label: {
                                Text("Sign in")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(height:55)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                    
                                    
                                }

                        
                            }
                        }
                        .padding(.top, 20)
                    )
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
        .padding()
       
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LoginView()
        }
        
    }
}

