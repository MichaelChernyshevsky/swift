import SwiftUI

struct NoteEditorView: View {
    @Binding var note: Note?
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var content: String = ""

    var onSave: (Note) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }

                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationTitle(note == nil ? "New Note" : "Edit Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveNote()
                    }
                }
            }
            .onAppear {
                if let note = note {
                    title = note.title
                    content = note.content
                }
            }
        }
    }

    private func saveNote() {
        let newNote = Note(
            id: note?.id ?? UUID(),
            title: title,
            content: content,
            date: Date()
        )
        onSave(newNote)
        dismiss()
    }
}
