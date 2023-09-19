//
//  ContentView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/7/23.
//
import SwiftUI
import FirebaseAuth
import CoreData

class AuthViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @AppStorage("addressCompleted") var addressCompleted: Bool?
    @AppStorage("signUpCompleted") var signUpCompleted: Bool?
    
    var body: some View {
        ZStack {
            if authViewModel.isSignedIn {
                if let addressCompleted = addressCompleted, let signUpCompleted = signUpCompleted {
                    if addressCompleted && signUpCompleted {
                        HomeView()
                    } else if !addressCompleted && signUpCompleted {
                        Onboarding3()
                    } else {
                        Onboarding1()
                    }
                } else {
                    Onboarding1() //in case of nil
                }
            } else {
                if let addressCompleted = addressCompleted, let signUpCompleted = signUpCompleted {
                    if addressCompleted && signUpCompleted {
                        Placeholder()
                    } else if !signUpCompleted && !addressCompleted {
                        Onboarding1()
                    } else if !addressCompleted && signUpCompleted {
                        Onboarding3()
                    } else {
                        Onboarding1()
                    }
                } else {
                    Onboarding1() //in case of nil
                }
            }
        }
        .onAppear() {
            addressCompleted = UserDefaults.standard.bool(forKey: "addressCompleted")
            signUpCompleted = UserDefaults.standard.bool(forKey: "signUpCompleted")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}



/*
class OnboardingViewModel: ObservableObject {
    @Published var isOnboardingCompleted = false
    @Published var isAddressCompleted = false
    
    
    
    /*
    func fetchOnboardingFlags() {
        // Fetch isOnboardingCompleted and isAddressCompleted flags from Core Data
        let fetchRequest: NSFetchRequest<Onboarding> = Onboarding.fetchRequest()
        do {
            let onboardingEntities = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            if let onboardingEntity = onboardingEntities.first {
                isOnboardingCompleted = onboardingEntity.isOnboardingCompleted
                isAddressCompleted = onboardingEntity.isAddressCompleted
            }
        } catch {
            print("Error fetching Onboarding entity: \(error)")
        }
    }
    */
    
    func determineNextView() -> AnyView {
        if isOnboardingCompleted && isAddressCompleted {
            return AnyView(HomeView())
        } else if !isOnboardingCompleted && !isAddressCompleted {
            return AnyView(Onboarding1())
        } else if isOnboardingCompleted && !isAddressCompleted {
            return AnyView(Onboarding3())
        } else {
            return AnyView(Placeholder())
        }
    }
}


*/
<<<<<<< HEAD

=======
>>>>>>> main
