import Foundation

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private var repository = NoteRepository()

    init() {
        self.notes = repository.loadNotes()
    }
    
    func addOrUpdateNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
        } else {
            notes.append(note)
        }
        repository.saveNotes(notes)
    }
    
    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        repository.saveNotes(notes)
    }
}

