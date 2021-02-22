//
//  Firebase+Injections.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//


import Foundation
import Resolver

//extension Resolver: ResolverRegistering {
  //public static func registerAllServices() {
    // register Firebase services
    //register { Functions.functions().useEmulator() }.scope(.application)
    //register { Firestore.firestore().useEmulator() }.scope(.application)
    
    // register application components
    
    //register { FirestoreTaskRepository() as TaskRepository }.scope(.application)
 // }
//}



/*extension Functions {
  func useEmulator() -> Functions {
    #if USE_FIREBASE_EMULATORS
    print("Using the Firebase Emulator for Cloud Functions, running on port 5001")
    self.useFunctionsEmulator(origin: "https://localhost:5001")
    #else
    print("Using Cloud Functions in production")
    #endif
    return self
  }
}

extension Firestore {
  func useEmulator() -> Firestore {
    #if USE_FIREBASE_EMULATORS
    print("Using the Firebase Emulator for Cloud Firestore, running on port 8080")
    let settings = self.settings
    settings.host = "localhost:8080"
    settings.isPersistenceEnabled = false
    settings.isSSLEnabled = false
    self.settings = settings
    #else
    print("Using Cloud Firestore in production")
    #endif
    return self
  }
}*/
