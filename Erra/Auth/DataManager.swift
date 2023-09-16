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
                        let address1 = data["address1"] as? String ?? ""
                        let address2 = data["address2"] as? String ?? ""
                        let address3 = data["address3"] as? String ?? ""
                   //     let city = data["city"] as? String ?? ""
                        
                        
                        let user = UserIDs(id: idString, name: name, address1: address1, address2:address2, address3: address3)
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
    
    func addAddress1( address: String, city: String, country: String, id:String) async throws{
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(id)
        // Use FieldValue.arrayUnion to add the address to an array field in the document.
        try await ref.updateData(["address1": FieldValue.arrayUnion([address])])
        try await ref.updateData(["address1": FieldValue.arrayUnion([city])])
        try await ref.updateData(["address1": FieldValue.arrayUnion([country])])

    }
    
    
    
    
    
    func addAddress2( address: String, city: String, country: String, id:String) async throws{
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(id)
        // Use FieldValue.arrayUnion to add the address to an array field in the document.
        try await ref.updateData(["address2": FieldValue.arrayUnion([address])])
        try await ref.updateData(["address2": FieldValue.arrayUnion([city])])
        try await ref.updateData(["address2": FieldValue.arrayUnion([country])])
    }
    
    
    
    func addAddress3( address: String, city: String, country: String, id:String) async throws{
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(id)
        // Use FieldValue.arrayUnion to add the address to an array field in the document.
        try await ref.updateData(["address3": FieldValue.arrayUnion([address])])
        try await ref.updateData(["address3": FieldValue.arrayUnion([city])])
        try await ref.updateData(["address3": FieldValue.arrayUnion([country])])
    }
    
    
}
