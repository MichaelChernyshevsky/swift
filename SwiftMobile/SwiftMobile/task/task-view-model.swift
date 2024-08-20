import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    
    @Published var selectedTask: TaskModel?
    
    func addTask(title: String) {
        let newTask = TaskModel(title: title)
        tasks.append(newTask)
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func toggleCompletion(for task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func updateTask(id: UUID, title: String) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].title = title
        }
    }
}
