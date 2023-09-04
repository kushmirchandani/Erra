//
//  Persistence.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/7/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Ignis")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Function to create a new 'Onboarding' instance
    func createOnboarding(isOnboardingCompleted: Bool) {
        let viewContext = container.viewContext
        let newOnboarding = Onboarding(context: viewContext)
        newOnboarding.isOnboardingCompleted = isOnboardingCompleted
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
