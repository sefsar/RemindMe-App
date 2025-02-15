import SwiftUI

struct HomeView: View {
    @AppStorage("languageCode") private var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    var body: some View {
        NavigationView {
            VStack {
                Text(LocalizationManager.localizedString("Home", languageCode: languageCode))
            }
            .navigationTitle(LocalizationManager.localizedString("Home", languageCode: languageCode))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 