import SwiftUI
import PhotosUI

struct AddPersonView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("languageCode") private var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    @State private var name: String = ""
    @State private var birthday: Date = Date()
    @State private var notes: String = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    var onSave: (Person) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            HStack {
                                Spacer()
                                Text(LocalizationManager.localizedString("Select Photo", languageCode: languageCode))
                                    .foregroundColor(.blue)
                                Spacer()
                            }
                        }
                }
                
                Section(header: Text(LocalizationManager.localizedString("PERSON DETAILS", languageCode: languageCode))) {
                    TextField(LocalizationManager.localizedString("Name", languageCode: languageCode), text: $name)
                    
                    DatePicker(
                        LocalizationManager.localizedString("Birthday", languageCode: languageCode),
                        selection: $birthday,
                        displayedComponents: .date
                    )
                    
                    TextField(LocalizationManager.localizedString("Notes", languageCode: languageCode), 
                             text: $notes, axis: .vertical)
                        .lineLimit(4...6)
                }
            }
            .navigationTitle(LocalizationManager.localizedString("Add Person", languageCode: languageCode))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocalizationManager.localizedString("Cancel", languageCode: languageCode)) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(LocalizationManager.localizedString("Save", languageCode: languageCode)) {
                        let person = Person(
                            name: name,
                            birthday: birthday,
                            notes: notes,
                            imageData: selectedImageData
                        )
                        onSave(person)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        }
    }
} 