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
    
    var body: some View {
        if authViewModel.isSignedIn {
            // Check onboarding and address completion statuses and display views accordingly
            let fetchRequest: NSFetchRequest<Onboarding> = Onboarding.fetchRequest()
            let onboardingEntities = try? managedObjectContext.fetch(fetchRequest)
            let isOnboardingCompleted = onboardingEntities?.first?.isOnboardingCompleted ?? false
            let isAddressCompleted = onboardingEntities?.first?.isAddressCompleted ?? false
            
            if isOnboardingCompleted && isAddressCompleted {
                HomeView()
            } else if !isOnboardingCompleted && !isAddressCompleted {
                Onboarding1()
            } else if isOnboardingCompleted && !isAddressCompleted {
                Onboarding3()
            } else {
                Placeholder()
            }
        } else {
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
