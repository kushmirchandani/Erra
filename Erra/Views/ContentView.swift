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
        
        if authViewModel.userIsLoggedIn {
            HomeView()
        } else if !isOnboardingCompleted {
            Onboarding1()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
