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
    
    func uploadData(key : String, dataString : String) throws {
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
    
    func uploadData(key : String, nameOfFile : String) throws {
        var error : StorageServiceError?
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(nameOfFile)

        let storageOperation = Amplify.Storage.uploadFile(key: key, local: filename)
        progressSink = storageOperation.progressPublisher.sink { progress in print("Progress: \(progress)") }
        resultSink = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                error = StorageServiceError.uploadError(storageError.errorDescription,storageError.recoverySuggestion)
            }
        }
        receiveValue: { data in
            print("Completed: \(data)")
        }
        if let error = error {
            throw error
        }
    }

    func uploadData(name: String, image : UIImage) throws  {
        guard let dataString = image.pngData() else { return }
        var error : StorageServiceError?
        let uploadOperation = Amplify.Storage.uploadData(key: name, data: dataString)
        
        
         progressSink = uploadOperation
             .progressPublisher
             .sink { progress in print("Progress: \(progress)") }

         resultSink = uploadOperation
             .resultPublisher
             .sink {
                 if case let .failure(storageError) = $0 {
                     print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                    error = StorageServiceError.uploadError(storageError.errorDescription,storageError.recoverySuggestion)
                 }
             }
             receiveValue: { data in
                 print("Completed: \(data)")
             }
        if let error = error {
            throw error
        }
    }
    
    func downloadToFile(named fileName : String, fromKey key : String) throws {
        var error : StorageServiceError?
        let downloadToFileName = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
        let storageOperation = Amplify.Storage.downloadFile(key: key, local: downloadToFileName)
        progressSink = storageOperation.progressPublisher.sink { progress in print("Progress: \(progress)") }
        resultSink = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                error = StorageServiceError.downloadError(storageError.errorDescription, storageError.recoverySuggestion)
            }
        }
        receiveValue: {
            print("Completed")
        }
        if let error = error {
            throw error
        }
    }
    
    func download(key : String) throws -> Data? {
        var error : StorageServiceError?
        var returnData : Data?
        let storageOperation = Amplify.Storage.downloadData(key: key)
        progressSink = storageOperation.progressPublisher.sink { progress in print("Progress: \(progress)") }
        resultSink = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                error = StorageServiceError.downloadError(storageError.errorDescription, storageError.recoverySuggestion)
            }
            
        }
        receiveValue: { data in
            returnData = data
        }
        if let error = error {
            throw error
        }
        return returnData
    }
    
    func getUrl(forKey key : String) throws -> URL? {
        var returnURL : URL?
        resultSink = Amplify.Storage.getURL(key: key)
            .resultPublisher
            .sink {
                if case let .failure(storageError) = $0 {
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                }
            }
            receiveValue: { url in
                returnURL = url
            }
        return returnURL
    }
    
    func listFiles() throws -> [StorageListResult.Item] {
        var error : StorageServiceError?
        var retList : [StorageListResult.Item] = [StorageListResult.Item]()
        resultSink = Amplify.Storage.list()
            .resultPublisher
            .sink {
                if case let .failure(storageError) = $0 {
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                    error = StorageServiceError.listFilesError(storageError.errorDescription, storageError.recoverySuggestion)
                }
            }
            receiveValue: { listResult in
                print("Completed")
                listResult.items.forEach { item in
                    retList.append(item)
                }
            }
        if let error = error {
            throw error
        }
        return retList
    }
    
    func removeFile(byKey key : String) throws {
        var error : StorageServiceError?
        resultSink = Amplify.Storage.remove(key: key)
            .resultPublisher
            .sink {
                if case let .failure(storageError) = $0 {
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                    error = StorageServiceError.removeFileError(storageError.errorDescription, storageError.recoverySuggestion)
                }
            }
            receiveValue: { data in
                print("Completed: Deleted \(data)")
            }
        if let error = error {
            throw error
        }
    }
}
