//
//  TaskRepository.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//


import Foundation
import Combine
import Resolver


public protocol ListenerRegistration : NSObjectProtocol {

    
    /**
     * Removes the listener being tracked by this FIRListenerRegistration. After the initial call,
     * subsequent calls have no effect.
     */
    func remove()
}

class BaseTaskRepository {
  @Published var tasks = [Task]()
}

protocol TaskRepository: BaseTaskRepository {
  func addTask(_ task: Task)
  func removeTask(_ task: Task)
  func updateTask(_ task: Task)
}

class TestDataTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
  override init() {
    super.init()
    self.tasks = testDataTasks
  }
  
  func addTask(_ task: Task) {
    tasks.append(task)
  }
  
  func removeTask(_ task: Task) {
    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
      tasks.remove(at: index)
    }
  }
  
  func updateTask(_ task: Task) {
    if let index = self.tasks.firstIndex(where: { $0.id == task.id } ) {
      self.tasks[index] = task
    }
  }
}

class LocalTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
  override init() {
    super.init()
    loadData()
  }
  
  func addTask(_ task: Task) {
    self.tasks.append(task)
    saveData()
  }
  
  func removeTask(_ task: Task) {
    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
      tasks.remove(at: index)
      saveData()
    }
  }
  
  func updateTask(_ task: Task) {
    if let index = self.tasks.firstIndex(where: { $0.id == task.id } ) {
      self.tasks[index] = task
      saveData()
    }
  }
  
  private func loadData() {
    if let retrievedTasks = try? Disk.retrieve("tasks.json", from: .documents, as: [Task].self) {
      self.tasks = retrievedTasks
    }
  }
  
  private func saveData() {
    do {
      try Disk.save(self.tasks, to: .documents, as: "tasks.json")
    }
    catch let error as NSError {
      fatalError("""
        Domain: \(error.domain)
        Code: \(error.code)
        Description: \(error.localizedDescription)
        Failure Reason: \(error.localizedFailureReason ?? "")
        Suggestions: \(error.localizedRecoverySuggestion ?? "")
        """)
    }
  }
}

class FirestoreTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
    func addTask(_ task: Task) {
        
    }
    
    func removeTask(_ task: Task) {
        
    }
    
    func updateTask(_ task: Task) {
        
    }
    
 // @Injected var db: FirebaseDatabase
  @Injected var authenticationService: AuthenticationService
  //@LazyInjected var functions: Functions

  var tasksPath: String = "tasks"
  var userId: String = "unknown"
  private var listenerRegistration: ListenerRegistration?
  private var cancellables = Set<AnyCancellable>()
  
  override init() {
    super.init()
    
    authenticationService.$user
      .compactMap { user in
        user?.uid
      }
      .assign(to: \.userId, on: self)
      .store(in: &cancellables)
    
    // (re)load data if user changes
    authenticationService.$user
      .receive(on: DispatchQueue.main)
      .sink { [weak self] user in
        self?.loadData()
      }
      .store(in: &cancellables)
  }
  
  private func loadData() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
    }
  }
}
  

