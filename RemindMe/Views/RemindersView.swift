import SwiftUI

struct RemindersView: View {
    @AppStorage("languageCode") private var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    var body: some View {
        NavigationView {
            VStack {
                Text(LocalizationManager.localizedString("Reminders", languageCode: languageCode))
            }
            .navigationTitle(LocalizationManager.localizedString("Reminders", languageCode: languageCode))
        }
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
} 