//
//  Placeholder.swift
//  Erra
//
//  Created by Heidi Schultz on 9/16/23.
//


import SwiftUI
import FirebaseAuth

struct Placeholder: View {
    @State private var isHomeViewPresented = false
   
    @StateObject private var viewModelLogin = LoginViewModel()
    
    
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
                ZStack{
                    //rectangle that comes out
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.30)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    VStack{
                        Text("Sign in")
                            .font(Font.custom("Inter-Regular", size: 24))
                            .padding(.bottom,40)
                            .padding(.top,60)
                        
                        
                        TextField("Email", text: $viewModelLogin.email)
                            .padding()
                            .background(
                               VStack {
                                   Color.white.opacity(0.4)
                                   Rectangle().frame(height: 1).foregroundColor(.gray)
                                   
                               }
                            )
                            .frame(width: UIScreen.main.bounds.width * 0.80)
                        
                        SecureField("Password", text: $viewModelLogin.password)
                            .padding()
                            .background(
                                VStack {
                                    Color.white.opacity(0.4)
                                    Rectangle().frame(height: 1).foregroundColor(.gray)
                                }
                            )
                            .frame(width: UIScreen.main.bounds.width * 0.80)
                        
                        Button(action: {
                            viewModelLogin.Login() { loginSuccess in
                                if loginSuccess {
                                    
                                    isHomeViewPresented.toggle()
                                } else {
                                
                                    print("Login failed")
                                }
                            }
                        }) {
                            Text("Sign in")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width * 0.80, height: 40)
                                .background(Color.black)
                                .cornerRadius(10)
                                .padding(.top, 20)
                                
                        }
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                //fix static
                Image("Logo")
                    .resizable()
                    .frame(width:200,height:200)
                    .aspectRatio(contentMode: .fit)
                    .position(x:290, y: 700)
                
              
                // sign in button
                
              
                   
                
                    
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.white)
        }
    }
}



struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder()
    }
}


final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func Login(completion: @escaping (Bool) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            print("Please fill out all required fields.")
            completion(false)
            return
        }
        
        // Call login from AuthenticationManager with a completion handler
        AuthenticationManager.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let authDataResultModel):
                print("Success")
                // You can use authDataResultModel here if needed
                completion(true)
            case .failure(let error):
                print("Error: \(error)")
                completion(false)
            }
        }
    }
}
