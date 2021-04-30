//
//  CoreDataManager.swift
//  Stalarm
//
//  Created by Andrean Lay on 29/04/21.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Stalarm")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addConvertionHistory(sourceDate: String, sourceTZ: String, targetTZ: String, resultDate: String) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let newHistory = ConvertionHistory(context: context)
        newHistory.sourceDate = sourceDate
        newHistory.sourceTimeZone = sourceTZ
        newHistory.targetTimeZone = targetTZ
        newHistory.resultDate = resultDate
        
        self.saveContext()
    }
    
    func deleteConvertionHistory(history: ConvertionHistory) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(history)
        
        self.saveContext()
    }
    
    func fetchAllConvertionHistory() -> [ConvertionHistory] {
        let context = self.persistentContainer.viewContext
        
        let request = ConvertionHistory.fetchRequest() as NSFetchRequest<ConvertionHistory>
        let histories = try? context.fetch(request)
        
        return histories!
    }
}
