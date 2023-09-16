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
    @Published var userIsLoggedIn = false
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.userIsLoggedIn = user != nil
        }
    }
}

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    var body: some View {
        let fetchRequest: NSFetchRequest<Onboarding> = Onboarding.fetchRequest()
        
        let onboardingEntities = try? managedObjectContext.fetch(fetchRequest)
        let isOnboardingCompleted = onboardingEntities?.first?.isOnboardingCompleted ?? false
        let isAddressCompleted = onboardingEntities?.first?.isAddressCompleted ?? false
        
        if authViewModel.userIsLoggedIn && isOnboardingCompleted && isAddressCompleted {
            HomeView()
        } else if !isOnboardingCompleted && !isAddressCompleted {
            Onboarding1()
        } else if isOnboardingCompleted && !isAddressCompleted{
            Onboarding3()
           }
        else{
            Placeholder()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
