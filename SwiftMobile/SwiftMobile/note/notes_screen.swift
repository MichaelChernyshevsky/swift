import SwiftUI

struct NotesView: View {
    @StateObject private var viewModel = NoteViewModel()
    @State private var showingNoteEditor = false
    @State private var editingNote: Note?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    VStack(alignment: .leading) {
                        Text(note.title)
                            .font(.headline)
                        Text(note.content)
                            .font(.subheadline)
                            .lineLimit(1)
                    }
                    .onTapGesture {
                        editingNote = note
                        showingNoteEditor = true
                    }
                }
                .onDelete(perform: viewModel.deleteNotes)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Notes").font(.system(size: 20, weight: .heavy))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editingNote = nil
                        showingNoteEditor = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNoteEditor) {
                NoteEditorView(note: $editingNote, onSave: { note in
                    viewModel.addOrUpdateNote(note)
                })
            }
        }
    }
}
