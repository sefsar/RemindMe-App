import SwiftUI

struct LocalizedText: ViewModifier {
    let key: String
    @AppStorage("languageCode") var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    func body(content: Content) -> some View {
        Text(LocalizationManager.localizedString(key, languageCode: languageCode))
    }
}

extension View {
    func localizedText(_ key: String) -> some View {
        modifier(LocalizedText(key: key))
    }
} 
