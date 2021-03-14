//
//  Folder.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/10/21.
//

import Foundation

public class Folder {
    private var fileHandle: FileHandle!

    // Return folder URL, create it if not existing yet.
    // Return nil to trigger a crash if the folder creation fails.
    // Not using lazy because we need to recreate when clearLogs is called.
    //
    var _folderURL: URL?
    private func folderURL(url: URL) -> URL? {
        guard _folderURL == nil else { return _folderURL }

        var folderURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        folderURL.appendPathComponent("Logs")

        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            } catch {
                print("Failed to create the log folder: \(folderURL)! \n\(error)")
                return nil // To trigger crash.
            }
        }
        _folderURL = folderURL
        return folderURL
    }

    // Return file URL, create it if not existing yet.
    // Return nil to trigger a crash if the file creation fails.
    // Not using lazy because we need to recreate when clearLogs is called.
    //
    private var _fileURL: URL?
    private var fileURL: URL! {
        guard _fileURL == nil else { return _fileURL }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: Date())

        var fileURL: URL = self._folderURL!
        fileURL.appendPathComponent("\(dateString).log")

        if !FileManager.default.fileExists(atPath: fileURL.path) {
            if !FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil) {
                print("Failed to create the log file: \(fileURL)!")
                return nil // To trigger crash.
            }
        }
        _fileURL = fileURL
        return fileURL
    }

    // Avoid creating DateFormatter for time stamp as Logger may count into execution budget.
    //
    private lazy var timeStampFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()

    // Use this dispatch queue to make the log file access is thread-safe.
    // Public methods use performBlockAndWait to access the resource; private methods don't.
    //
    private lazy var ioQueue: DispatchQueue = {
        return DispatchQueue(label: "ioQueue")
    }()

    private func performBlockAndWait<T>(_ block: () -> T) -> T {
        return ioQueue.sync {
            return block()
        }
    }
}
