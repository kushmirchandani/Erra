//
//  Onboarding2.swift
//  Erra
//
//  Created by Heidi Schultz on 8/30/23.
//


import SwiftUI
import FirebaseAuth
import CoreData

struct Onboarding2: View {
    @StateObject private var viewModel1 = Login1ViewModel()
    @State private var isOnboarding3Active = false
    @State private var isPresentingOnboarding3 = false
    @StateObject private var viewModel2 = NameViewModel()
    let managedObjectContext = PersistenceController.shared.container.viewContext
    @StateObject private var viewModel = Onboarding2ViewModel()
    
 
    
    
    
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
                //rectangle that comes up
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
                    
                    
                    //first name
                    TextField("Enter Your First name", text: $viewModel2.firstName)
                        .padding()
                        .background(
                            VStack {
                                Color.white.opacity(0.4)
                                Rectangle().frame(height: 1).foregroundColor(.gray)
                            }
                        )
                        .onChange(of: viewModel2.firstName) { newValue in
                                if newValue.count > 15 {
                                    viewModel2.firstName = String(newValue.prefix(15))
                                }
                            }
                    
                    //last name
                    TextField("Enter Your Last name", text: $viewModel2.lastName)
                        .padding()
                        .background(
                            VStack {
                                Color.white.opacity(0.4)
                                Rectangle().frame(height: 1).foregroundColor(.gray)
                            }
                        )
                        .onChange(of: viewModel2.lastName) { newValue in
                                if newValue.count > 15 {
                                    viewModel2.lastName = String(newValue.prefix(15))
                                }
                            }
                    
                //email
                    TextField("Enter Your Email", text: $viewModel1.email)
                        .padding()
                        .background(
                            VStack {
                                Color.white.opacity(0.4)
                                Rectangle().frame(height: 1).foregroundColor(.gray)
                            }
                        )
                    
                    //password
                    SecureField("Enter Your Password", text: $viewModel1.password)
                        .padding()
                        .background(
                            VStack {
                                Color.white.opacity(0.4)
                                Rectangle().frame(height: 1).foregroundColor(.gray)
                            }
                        )
                  
                    
                    //sign up button
                    Button(action: {
                        viewModel1.signUp() { success in
                                if success {
                                    // Fetching user UID for the button
                                    if let user = Auth.auth().currentUser {
                                        let uid = user.uid
                                        viewModel2.nameFunc(forUser: uid) { success in
                                            if success {
                                                viewModel.CoreDataVM1.updateOnboardingStatus(forUser: uid)
                                                isPresentingOnboarding3 = true
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
    
    func signUp(completion: @escaping (Bool) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            print("Please fill out all required fields.")
            completion(false)
            return
        }
        
        // Call createUser from AuthenticationManager with a completion handler
        AuthenticationManager.shared.createUser(email: email, password: password) { result in
            switch result {
            case .success:
                print("Success")
                completion(true)
            case .failure(let error):
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

final class CoreDataVM: ObservableObject {
    private let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func updateOnboardingStatus(forUser uid: String) {
        // Fetch and update the Onboarding entity
        let fetchRequest: NSFetchRequest<Onboarding> = Onboarding.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uniqueIdentifier == %@", uid)
        
    
        do {
            let onboardingEntities = try managedObjectContext.fetch(fetchRequest)
            if let onboardingEntity = onboardingEntities.first {
                // Update the attribute
                onboardingEntity.isOnboardingCompleted = true

                // Save managed object context to persist change
                try managedObjectContext.save()
            }
        } catch {
            print("Error updating Onboarding entity: \(error)")
        }
    }
}

final class Onboarding2ViewModel : ObservableObject {
@StateObject var CoreDataVM1 = CoreDataVM(managedObjectContext: PersistenceController.shared.container.viewContext)
}
