import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle: String = ""
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .red).onTapGesture {
                                        viewModel.toggleCompletion(for: task)
                                    }
                            Text(task.title)
                                .strikethrough(task.isCompleted, color: .black)
                            Spacer()
                            Button(action: {
                                viewModel.selectedTask = task
                                isEditing = true
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
                .listStyle(PlainListStyle())
                
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        viewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .disabled(newTaskTitle.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Task Planner")
            .sheet(isPresented: $isEditing) {
                if let selectedTask = viewModel.selectedTask {
                    TaskEditView(task: selectedTask, viewModel: viewModel)
                }
            }
        }
    }
}
