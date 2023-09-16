//
//  AuthenticantionManager .swift
//  Erra
//
//  Created by Heidi Schultz on 7/13/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    private var email: String = ""
    private var password: String = ""
    private var errorMessage: String = ""
    
    func createUser(email: String, password: String, completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                completion(.failure(error))
            } else if let authDataResult = result {
                let result = AuthDataResultModel(user: authDataResult.user)
                print("User created successfully with UID: \(result.uid)")
                completion(.success(result))
            }
        }
    }
    
    
    func logout() {
            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        }
    
    
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                completion(.failure(error))
            } else if let authDataResult = result {
                let result = AuthDataResultModel(user: authDataResult.user)
                print("User logged in successfully with UID: \(result.uid)")
                completion(.success(result))
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = "Attempting Validation"
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Not All Fields Filled"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Enter A Valid Email"
            return false
        }
        return true
    }
}
