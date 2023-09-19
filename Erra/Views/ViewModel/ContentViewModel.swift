//
//  ContentViewModel.swift
//  Erra
//
//  Created by Kush Mirchandani on 9/16/23.
//

import FirebaseAuth
import Foundation

//class ContentViewModel: ObservableObject {
//    @Published var currentUserId: String = ""
//    private var handler: AuthStateDidChangeListenerHandle?
//    init() {
//        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
//            DispatchQueue.main.async {
//                self?.currentUserId = user?.uid ?? ""
//            }
//        }
//    }
//    
//    public var isSignedIn: Bool {
//        return Auth.auth().currentUser != nil
//    }
//}
