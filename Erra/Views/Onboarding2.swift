//
//  Onboarding2.swift
//  Erra
//
//  Created by Heidi Schultz on 8/30/23.
//
import SwiftUI

struct Onboarding2: View {
    @StateObject private var viewModel1 = Login1ViewModel()
    @State private var isOnboarding3Active = false
    @State private var isPresentingOnboarding3 = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Image("onboardFire")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55)
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
                        .foregroundColor(.white)
                }
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.30)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 210, height: 200)
                    .offset(x: 70, y: -50)
                
                VStack {
                    Text("Let Ignis get to know you!")
                        .font(Font.custom("Inter-Regular", size: 24))
                        .frame(width: UIScreen.main.bounds.width * 0.93)
                        .padding(.top, 60)
                    
                    TextField("Enter Your Name", text: $viewModel1.name)
                        .padding()
                        .background(
                            VStack {
                                Color.white.opacity(0.4)
                                Rectangle().frame(height: 1).foregroundColor(.gray)
                            }
                        )
                    
                    
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
                        viewModel1.signIn() { success in
                            if success {
                                isPresentingOnboarding3 = true
                            }
                        }
                    }) {
                        Text("Sign up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.top, 50)
                    }
                }
                .offset(y: 120)
                .padding(.bottom, 50)
                .frame(width: UIScreen.main.bounds.width * 0.8)
                
                HStack(spacing: 130) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: 150, height: 15)
                            .foregroundColor(.gray)
                            .cornerRadius(7)
                        
                        Rectangle()
                            .frame(width: 50, height: 15)
                            .foregroundColor(.black)
                            .cornerRadius(7)
                    }
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height)
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.white)
            .fullScreenCover(isPresented: $isPresentingOnboarding3) {
                Onboarding3()
            }
        }
        .navigationBarHidden(true)
    }
}

struct Onboarding2_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding2()
    }
}

final class Login1ViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    
    func signIn(completion: @escaping (Bool) -> Void) {
        guard !email.isEmpty, !password.isEmpty, !name.isEmpty else {
            print("Please fill out all required fields.")
            completion(false)
            return
        }
        
        Task {
            do {
                let returnedUserData: () = try await AuthenticationManager.shared.createUser(email: email, password: password, name: name)
                print("Success")
                print(returnedUserData)
                completion(true)
            } catch {
                print("Error: \(error)")
                completion(false)
            }
        }
    }
}
