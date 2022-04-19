### **Demonstration of works app:**
 
https://user-images.githubusercontent.com/87602980/164076801-6007113b-0f33-49bf-98b5-7a577e412775.mp4

### **Project implementation:**

* **Composite:**
```swift
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
```
