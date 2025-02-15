import SwiftUI

struct PersonsView: View {
    @AppStorage("languageCode") private var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"
    @State private var persons: [Person] = []
    @State private var showingAddPerson = false
    @State private var selectedPerson: Person?
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(persons) { person in
                        PersonCard(person: person)
                            .onTapGesture {
                                selectedPerson = person
                            }
                    }
                }
                .padding()
            }
            .navigationTitle(LocalizationManager.localizedString("People", languageCode: languageCode))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddPerson = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 25, weight: .bold))
                    }
                }
            }
            .sheet(isPresented: $showingAddPerson) {
                AddPersonView { person in
                    persons.append(person)
                }
            }
            .sheet(item: $selectedPerson) { person in
                PersonDetailView(person: person)
            }
        }
    }
}

struct PersonCard: View {
    let person: Person
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text(person.name)
                .font(.headline)
            
            Text(person.birthday, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView()
    }
} 
           
