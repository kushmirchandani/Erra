//
//  Onboarding3.swift
//  Erra
//
//  Created by Heidi Schultz on 9/1/23.
//


/*
 TO DO:
 
 LINK NAME FIELD TO Users firestore database and have it linked to each UUID
 
 character limit on name
 
 first and last name?
 
 only proceed if both fields are complete and meeet req
 
 
 
 
 
 
 */
/*
import SwiftUI
import FirebaseAuth

struct Onboarding3: View {
    @State private var isOnboarding2ctive = false
    @State private var isPresentingOnboarding2 = false
    @StateObject private var viewModel2 = NameViewModel()
    @ObservedObject var userViewModel: UserViewModel
    
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
                    

                 
                        
                    
                    Button(action: {
                        viewModel2.nameFunc() { success in
                            if success {
                                isPresentingOnboarding2 = true
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
            .fullScreenCover(isPresented: $isPresentingOnboarding2) {
                Onboarding2()
            }
        }
        .navigationBarHidden(true)
    }
}

struct Onboarding3_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding3()
    }
}


/* final class NameViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
   
   
    
    func nameFunc(forUser user: UserIDs, completion: @escaping (Bool) -> Void) {
        guard !firstName.isEmpty, !lastName.isEmpty else {
            print("Please fill out all required fields.")
            completion(false)
            return
        }
        
        Task {
            do {
                let name1 = firstName + " " + lastName
                let displayName: () = try await
                DataManager.shared.addName(name: name1, forUser: user)
                
                print("Success")
                print(displayName)
                completion(true)
            } catch {
                print("Error: \(error)")
                completion(false)
            }
        }
    }
}

*/

*/
