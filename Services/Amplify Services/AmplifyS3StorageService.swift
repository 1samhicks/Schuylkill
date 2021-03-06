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
    
    func uploadData(key : String, dataString : String) {
        let data = dataString.data(using: .utf8)!
        let storageOperation = Amplify.Storage.uploadData(key: key, data: data)
        progressSink = storageOperation.progressPublisher.sink { progress in print("Progress: \(progress)") }
        resultSink = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        }
        receiveValue: { data in
            print("Completed: \(data)")
        }
    }
    
    func uploadData(key : String, nameOfFile : String) {
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(nameOfFile)

        let storageOperation = Amplify.Storage.uploadFile(key: key, local: filename)
        progressSink = storageOperation.progressPublisher.sink { progress in print("Progress: \(progress)") }
        resultSink = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        }
        receiveValue: { data in
            print("Completed: \(data)")
        }
    }

    func uploadData(name: String, image : UIImage)  {
        guard let dataString = image.pngData() else { return }
        let uploadOperation = Amplify.Storage.uploadData(key: name, data: dataString)
        
        
         progressSink = uploadOperation
             .progressPublisher
             .sink { progress in print("Progress: \(progress)") }

         resultSink = uploadOperation
             .resultPublisher
             .sink {
                 if case let .failure(storageError) = $0 {
                     print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                 }
             }
             receiveValue: { data in
                 print("Completed: \(data)")
             }
    }
    
    func downloadToFile(named fileName : String, fromKey key : String) {
        let downloadToFileName = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
        let storageOperation = Amplify.Storage.downloadFile(key: key, local: downloadToFileName)
        progressSink = storageOperation.progressPublisher.sink { progress in print("Progress: \(progress)") }
        resultSink = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        }
        receiveValue: {
            print("Completed")
        }
    }
    
    func download(key : String) -> Data? {
        var returnData : Data?
        let storageOperation = Amplify.Storage.downloadData(key: key)
        progressSink = storageOperation.progressPublisher.sink { progress in print("Progress: \(progress)") }
        resultSink = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        }
        receiveValue: { data in
            returnData = data
        }
        return returnData
    }
}
