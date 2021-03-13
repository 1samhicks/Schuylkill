//
//  Task.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import Foundation
import Resolver

enum TaskPriority: Int, Codable {
  case high
  case medium
  case low
}

struct Task: Encodable, Identifiable {
    @DocumentID var id: String?
  var title: String
  var priority: TaskPriority
  var completed: Bool
  // @ServerTimestamp var createdTime: Date?
  var userId: String?
    init(title: String, priority: TaskPriority, completed: Bool) {
        self.title=title
        self.priority=priority
        self.completed=completed
    }
    init(from decoder: Decoder) throws {

    }
}

struct Task: Decodable {

}

#if DEBUG
let testDataTasks  = [
    Task(title: "Implement UI", priority: .medium, completed: true),
    Task(title: "Connect to Firebase", priority: .medium, completed: false),
    Task(title: "????", priority: .high, completed: false),
    Task(title: "PROFIT!!!", priority: .high, completed: false)
]
#endif
