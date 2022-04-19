//
//  Task.swift
//  TaskManager
//
//  Created by user on 18.04.2022.
//
import Foundation

protocol TaskCompositeProtocol {
    var name: String { get set }
    func showTask() -> Any
    func addTask(t: TaskCompositeProtocol)
    var count: Int {get}
}

class Task: TaskCompositeProtocol {
    var name: String
    var count: Int {
        return taskArray.count
    }
    
    private var taskArray: [TaskCompositeProtocol] = []
    
    init(name: String) {
        self.name = name
    }
    
    func showTask() -> Any {
        return taskArray
    }
    
    func addTask(t: TaskCompositeProtocol) {
        taskArray.append(t)
    }
}

