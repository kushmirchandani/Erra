//
//  ErraApp.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/7/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ErraApp: App {
    // Step 3: Create an instance of NSPersistentContainer for your Core Data model.
    let persistenceController = PersistenceController.shared
    
    // Firebase setup can be here, like in your AppDelegate.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            // Pass the managedObjectContext to Onboarding1
            Onboarding1()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            // Pass the managedObjectContext to Onboarding2
            Onboarding2()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
