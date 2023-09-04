//
//  ContentView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/7/23.
//

import SwiftUI
import FirebaseAuth

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
    
    var body: some View {
        if authViewModel.userIsLoggedIn {
            HomeView()
        } else {
            Onboarding1()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}

