//
//  DataManager.swift
//  Erra
//
//  Created by Heidi Schultz on 9/2/23.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    
    static let shared = DataManager()
    
    @Published var users: [UserIDs] = []
    
    init(){
        fetchUserIDs()
    }
    
    func fetchUserIDs() {
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    if let idString = data["id"] as? String {
                        let name = data["name"] as? String ?? ""
                        let user = UserIDs(id: idString, name: name)
                        self.users.append(user)
                    }
                }
            }
        }
    }
    
    func addName(name: String,id: String) async throws{
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(id)
        ref.setData(["name":name, "id": id]){error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
