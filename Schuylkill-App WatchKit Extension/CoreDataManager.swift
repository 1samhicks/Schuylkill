    //
    //  DataManager.swift
    //  Schuylkill
    //
    //  Created by Sam Hicks on 1/30/21.
    //

    import Foundation
    import CoreData
    import CoreMotion
    
    public class CoreDataManager {
        
        static let shared : CoreDataManager = CoreDataManager()
        
        private var managedObjectContext : NSManagedObjectContext!
        
        public init() {
            abort()
        }
        
        init(completionClosure: @escaping () -> () =  {}) {
        //This resource is the same name as your xcdatamodeld contained in your project
        guard let modelURL = Bundle.main.url(forResource: "WorkoutModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Unable to resolve document directory")
            }
            let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
                DispatchQueue.main.sync(execute: completionClosure)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
        }
        
        func save() throws {
            managedObjectContext.performAndWait() {

            // Perform operations with the context.

            do {
                try managedObjectContext.save()
            } catch {
                print("Error saving context: \(error)")
                objc_exception_rethrow()
            }
        }
    }
    }
    
    extension CoreDataManager {
        func writeAcceleramotorData(accelerometerData : CMAccelerometerData) {
            let data = NSEntityDescription.insertNewObject(forEntityName: "AccelerometerData", into: managedObjectContext) as! CDAccelerometerData
            data.x = accelerometerData.acceleration.x
            data.y = accelerometerData.acceleration.y
            data.z = accelerometerData.acceleration.z
            data.timestamp = accelerometerData.timestamp
        }
        
        func writeAttitude(motion : CMDeviceMotion) {
            let data = NSEntityDescription.insertNewObject(forEntityName: "MotionAttitude", into: managedObjectContext) as! CDMotionAttitude
            data.pitch = motion.attitude.pitch
            data.yaw = motion.attitude.yaw
            data.roll = motion.attitude.roll
            data.timestamp = motion.timestamp
        }
        
        
    }
