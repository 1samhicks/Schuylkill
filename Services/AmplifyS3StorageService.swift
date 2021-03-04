//
//  S3StorageService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/26/21.
//

import Foundation
import Combine
import Amplify

class AmplifyS3StorageService : RuntimeService {
    
    
    // In your type's instance variables
    var resultSink: AnyCancellable?
    var progressSink: AnyCancellable?

    required public init() {
        
    }

    func uploadData(name: String, image : UIImage) -> StorageUploadDataOperation? {
        guard let dataString = image.pngData() else { return nil }
        let uploadOperation = Amplify.Storage.uploadData(key: name, data: dataString)
        return uploadOperation
        
        /***
         progressSink = storageOperation
             .progressPublisher
             .sink { progress in print("Progress: \(progress)") }

         resultSink = storageOperation
             .resultPublisher
             .sink {
                 if case let .failure(storageError) = $0 {
                     print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                 }
             }
             receiveValue: { data in
                 print("Completed: \(data)")
             }
         */
    }
}
