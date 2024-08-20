import SwiftUI

struct TaskEditView: View {
    @State private var title: String
    let task: TaskModel
    @ObservedObject var viewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode

    init(task: TaskModel, viewModel: TaskViewModel) {
        
        self.task = task
        self.viewModel = viewModel
        _title = State(initialValue: task.title)
    }

    var body: some View {
        VStack {
            TextField("Task Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Save") {
                viewModel.updateTask(id: task.id, title: title)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .disabled(title.isEmpty)
        }
        .padding()
    }
}
