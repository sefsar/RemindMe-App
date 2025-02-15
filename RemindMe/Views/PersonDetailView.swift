import SwiftUI

struct PersonDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("languageCode") private var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    @State private var person: Person
    @State private var isEditing = false
    @State private var editedName: String
    @State private var editedBirthday: Date
    @State private var editedNotes: String
    
    init(person: Person) {
        self._person = State(initialValue: person)
        self._editedName = State(initialValue: person.name)
        self._editedBirthday = State(initialValue: person.birthday)
        self._editedNotes = State(initialValue: person.notes)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.vertical)
                }
                
                Section(header: Text(LocalizationManager.localizedString("PERSON DETAILS", languageCode: languageCode))) {
                    if isEditing {
                        TextField(LocalizationManager.localizedString("Name", languageCode: languageCode), 
                                text: $editedName)
                        
                        DatePicker(
                            LocalizationManager.localizedString("Birthday", languageCode: languageCode),
                            selection: $editedBirthday,
                            displayedComponents: .date
                        )
                        
                        TextField(LocalizationManager.localizedString("Notes", languageCode: languageCode),
                                text: $editedNotes, axis: .vertical)
                            .lineLimit(4...6)
                    } else {
                        HStack {
                            Text(LocalizationManager.localizedString("Name", languageCode: languageCode))
                            Spacer()
                            Text(person.name)
                        }
                        
                        HStack {
                            Text(LocalizationManager.localizedString("Birthday", languageCode: languageCode))
                            Spacer()
                            Text(person.birthday, style: .date)
                        }
                        
                        if !person.notes.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(LocalizationManager.localizedString("Notes", languageCode: languageCode))
                                Text(person.notes)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle(isEditing ? 
                LocalizationManager.localizedString("Edit Person", languageCode: languageCode) :
                person.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEditing {
                        Button(LocalizationManager.localizedString("Cancel", languageCode: languageCode)) {
                            isEditing = false
                            // Reset edited values
                            editedName = person.name
                            editedBirthday = person.birthday
                            editedNotes = person.notes
                        }
                    } else {
                        Button(LocalizationManager.localizedString("Close", languageCode: languageCode)) {
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEditing {
                        Button(LocalizationManager.localizedString("Save", languageCode: languageCode)) {
                            // Update person with edited values
                            person.name = editedName
                            person.birthday = editedBirthday
                            person.notes = editedNotes
                            isEditing = false
                        }
                        .disabled(editedName.isEmpty)
                    } else {
                        Button(LocalizationManager.localizedString("Edit", languageCode: languageCode)) {
                            isEditing = true
                        }
                    }
                }
            }
        }
    }
} 