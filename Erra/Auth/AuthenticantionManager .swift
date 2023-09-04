//
//  AuthenticantionManager .swift
//  Erra
//
//  Created by Heidi Schultz on 7/13/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel{
    let uid: String
    let email: String?
    let photoUrl: String?
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
final class AuthenticationManager{
    static let shared = AuthenticationManager()
    private init(){}
    
    func createUser(email: String, password: String) async throws {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let result = AuthDataResultModel(user: authDataResult.user)
            
    
            
            print("User created successfully with UID: \(result.uid)")
        } catch {
            print("Error creating user: \(error.localizedDescription)")
            throw error // Rethrow the error to the caller if needed
        }
    }
    
    func logout() {
            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        }

}
