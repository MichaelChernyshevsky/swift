import Foundation

class NoteRepository {
    private let userDefaultsKey = "notes"
    private var cache = NSCache<NSString, NSArray>()

    // Загружает все заметки из кэша, если они есть, иначе из UserDefaults
    func loadNotes() -> [Note] {
        if let cachedNotes = cache.object(forKey: userDefaultsKey as NSString) as? [Note] {
            return cachedNotes
        }
        
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let notes = try? JSONDecoder().decode([Note].self, from: data) else {
            return []
        }
        
        // Сохраняем загруженные заметки в кэш
        cache.setObject(notes as NSArray, forKey: userDefaultsKey as NSString)
        return notes
    }

    // Сохраняет все заметки в UserDefaults и обновляет кэш
    func saveNotes(_ notes: [Note]) {
        if let data = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
            cache.setObject(notes as NSArray, forKey: userDefaultsKey as NSString)
        }
    }

    // Добавляет новую заметку и сохраняет список
    func addNote(_ note: Note) {
        var notes = loadNotes()
        notes.append(note)
        saveNotes(notes)
    }

    // Удаляет заметку и сохраняет список
    func deleteNote(_ note: Note) {
        var notes = loadNotes()
        notes.removeAll { $0.id == note.id }
        saveNotes(notes)
    }

    // Обновляет существующую заметку и сохраняет список
    func updateNote(_ note: Note) {
        var notes = loadNotes()
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            saveNotes(notes)
        }
    }

    // Очистка кэша, если необходимо
    func clearCache() {
        cache.removeAllObjects()
    }
}
