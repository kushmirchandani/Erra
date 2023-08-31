//
//  LoginView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/8/23.
//
/*
import SwiftUI
@MainActor
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color.white.opacity(1)
            
            VStack(spacing: 20) {
                Spacer()
                
//                RoundedRectangle(cornerRadius: 25)
//                    .fill(Color(#colorLiteral(red: 0.9125000238418579, green: 0.9125000238418579, blue: 0.9125000238418579, alpha: 0.2)))
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal)
//                    .overlay(
                        VStack {
                            Text("Welcome to Erra")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Test Prep Simplified")
                           
                            VStack {
                                TextField("Enter Your Email", text: $viewModel.email)
                                    .padding()
                                    .background(
                                        VStack {
                                            Color.white.opacity(0.4)
                                            Rectangle().frame(height: 1).foregroundColor(.gray)
                                        }
                                    )
                                                        
                                SecureField("Enter Your Password", text: $viewModel.password)
                                    .padding()
                                    .background(
                                        VStack {
                                            Color.white.opacity(0.4)
                                            Rectangle().frame(height: 1).foregroundColor(.gray)
                                                
                                        }
                                    )
                            }
                            
                            Button(action: {
                                viewModel.signIn()
                            }) {
                                Text("Sign in")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 55)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
//                            
//                            Text("or")
//                                .padding(10)
                            
                            VStack(spacing: 20) {
//                                Button(action: {}) {
//                                    HStack {
//                                        Image(systemName: "applelogo")
//                                            .resizable()
//                                            .frame(width: 20, height: 25)
//                                        Text("Apple Sign In")
//                                            .padding(5)
//                                    }
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                                    .padding(10)
//                                    .frame(maxWidth: .infinity) // <-- Added modifier
//                                    .background(Color.black)
//                                    .cornerRadius(10)
//                                }
                                
//                                Button(action: {}) {
//                                    HStack {
//                                        Image("Google Icon White")
//                                            .resizable()
//                                            .frame(width: 20, height: 20)
//                                        Text("Google Sign In")
//                                            .padding(5)
//                                    }
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                                    .padding(10)
//                                    .frame(maxWidth: .infinity) // <-- Added modifier
//                                    .background(Color.black)
//                                    .cornerRadius(10)
//                                }
                            }
                        }
                        .padding(.top, 20)
//                    )
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
        .padding()
    }
}

    
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
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack{
                LoginView()
            }
            
        }
    }

 /**/*/
