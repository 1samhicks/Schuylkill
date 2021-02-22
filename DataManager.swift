//
//  DataManager.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/3/21.
//

import Foundation
import Combine

public class DataManager {
    
    private var coreDataManager: CoreDataManager
    private var watchPipe : WatchPipe
    private var firebaseUploader : FirebaseUploader
    
    init(coreDataManager cdm : CoreDataManager, watchPipe wp : WatchPipe, firebaseUploader fu : FirebaseUploader) {
        coreDataManager = cdm
        watchPipe = wp
        firebaseUploader = fu
    }
}


