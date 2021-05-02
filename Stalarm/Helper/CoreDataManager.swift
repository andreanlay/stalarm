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
    
    func addConversionHistory(sourceDate: String, sourceTZ: String, targetTZ: String, resultDate: String) {
        let context = persistentContainer.viewContext
        
        let newHistory = ConversionHistory(context: context)
        newHistory.sourceDate = sourceDate
        newHistory.sourceTimeZone = sourceTZ
        newHistory.targetTimeZone = targetTZ
        newHistory.resultDate = resultDate
        
        self.saveContext()
    }
    
    func deleteConversionHistory(history: ConversionHistory) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(history)
        
        self.saveContext()
    }
    
    func fetchAllConversionHistory() -> [ConversionHistory] {
        let context = self.persistentContainer.viewContext
        
        let request = ConversionHistory.fetchRequest() as NSFetchRequest<ConversionHistory>
        let histories = try? context.fetch(request)
        
        return histories!
    }
    
    func fetchAllAlarm() -> [Alarm] {
        let context = self.persistentContainer.viewContext
        
        let request = Alarm.fetchRequest() as NSFetchRequest<Alarm>
        let alarms = try? context.fetch(request)
        
        return alarms!
    }
    
    func addAlarm(name: String, time: Date, repeatDay: [String], music: String, walkDuration: Int16) {
        let context = persistentContainer.viewContext
        
        let alarm = Alarm(context: context)
        alarm.name = name
        alarm.time = time
        alarm.repeatDay = repeatDay
        alarm.music = music
        alarm.walkDuration = walkDuration
        
        self.saveContext()
    }
    
    func setAlarmStatus(to status: Bool, for alarm: Alarm) {
        alarm.active = status
        
        self.saveContext()
    }
    
    func deleteAlarm(alarm: Alarm) {
        let context = self.persistentContainer.viewContext
        context.delete(alarm)
        
        self.saveContext()
    }
    
    func fetchAllTimer() -> [CountdownTimer] {
        let context = self.persistentContainer.viewContext
        
        let request = CountdownTimer.fetchRequest() as NSFetchRequest<CountdownTimer>
        let timers = try? context.fetch(request)
        
        return timers!
    }
    
    func addTimer(name: String, duration: Int32, music: String) {
        let context = persistentContainer.viewContext
        
        let timer = CountdownTimer(context: context)
        timer.name = name
        timer.duration = duration
        timer.music = music
        
        self.saveContext()
    }
    
    func setTimerStatus(to status: Bool, for timer: CountdownTimer) {
        timer.active = status
        
        self.saveContext()
    }
    
    func deleteTimer(timer: CountdownTimer) {
        let context = self.persistentContainer.viewContext
        context.delete(timer)
        
        self.saveContext()
    }
}
