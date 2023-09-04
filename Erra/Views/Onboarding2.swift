//
//  Onboarding2.swift
//  Erra
//
//  Created by Heidi Schultz on 8/30/23.
//
import SwiftUI
import FirebaseAuth

struct Onboarding2: View {
    @StateObject private var viewModel1 = Login1ViewModel()
    @State private var isHomeViewActive = false
    @State private var isPresentingHomeView = false
    @StateObject private var viewModel2 = NameViewModel()
 
    
    
    
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
                    
                    TextField("Enter Your First name", text: $viewModel2.firstName)
                        .padding()
                        .background(
                            VStack {
                                Color.white.opacity(0.4)
                                Rectangle().frame(height: 1).foregroundColor(.gray)
                            }
                        )
                    TextField("Enter Your Last name", text: $viewModel2.lastName)
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
                                    // Fetching user UID for the button
                                    if let user = Auth.auth().currentUser {
                                        let uid = user.uid
                                        viewModel2.nameFunc(forUser: uid) { success in
                                            if success {
                                                isPresentingHomeView = true
                                            }
                                        }
                                    } else {
                                        print("No user authenticated")
                                    }
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
            .fullScreenCover(isPresented: $isPresentingHomeView) {
                HomeView()
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

final class NameViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var user = ""
   
   
    
    func nameFunc(forUser uid: String, completion: @escaping (Bool) -> Void) {
        guard !firstName.isEmpty, !lastName.isEmpty else {
            print("Please fill out all required fields.")
            completion(false)
            return
        }
        
        Task {
            do {
                let name1 = firstName + " " + lastName
                try await DataManager.shared.addName(name: name1, id: uid)
                
                print("Success")
                completion(true)
            } catch {
                print("Error: \(error)")
                completion(false)
            }
        }
    }
}

