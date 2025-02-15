import SwiftUI

struct SettingsView: View {
    @AppStorage("enableNotifications") private var enableNotifications = true
    @AppStorage("reminderTime") private var reminderTime = "24 hours before"
    @AppStorage("colorScheme") private var colorScheme: Int = 0
    @AppStorage("languageCode") private var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    let reminderOptions = ["12 hours before", "24 hours before", "2 days before", "1 week before"]
    let appearanceOptions = ["System", "Light", "Dark"]
    let languageOptions = [
        ("English", "en"),
        ("Deutsch", "de"),
        ("Türkçe", "tr")
    ]
    
    var localizedReminderOptions: [String] {
        [
            LocalizationManager.localizedString("12 hours before", languageCode: languageCode),
            LocalizationManager.localizedString("24 hours before", languageCode: languageCode),
            LocalizationManager.localizedString("2 days before", languageCode: languageCode),
            LocalizationManager.localizedString("1 week before", languageCode: languageCode)
        ]
    }
    
    var localizedAppearanceOptions: [String] {
        [
            LocalizationManager.localizedString("System", languageCode: languageCode),
            LocalizationManager.localizedString("Light", languageCode: languageCode),
            LocalizationManager.localizedString("Dark", languageCode: languageCode)
        ]
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(LocalizationManager.localizedString("NOTIFICATIONS", languageCode: languageCode))) {
                    Toggle(LocalizationManager.localizedString("Enable Notifications", languageCode: languageCode),
                           isOn: $enableNotifications)
                    
                    HStack {
                        Text(LocalizationManager.localizedString("Reminder Time", languageCode: languageCode))
                        Spacer()
                        Picker(LocalizationManager.localizedString("Reminder Time", languageCode: languageCode), 
                               selection: $reminderTime) {
                            ForEach(localizedReminderOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                Section(header: Text(LocalizationManager.localizedString("APPEARANCE", languageCode: languageCode))) {
                    Picker(LocalizationManager.localizedString("Color Scheme", languageCode: languageCode), 
                          selection: $colorScheme) {
                        ForEach(0..<localizedAppearanceOptions.count, id: \.self) { index in
                            Text(localizedAppearanceOptions[index])
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker(LocalizationManager.localizedString("Language", languageCode: languageCode), 
                          selection: $languageCode) {
                        ForEach(languageOptions, id: \.1) { language in
                            Text(language.0).tag(language.1)
                        }
                    }
                }
                
                Section(header: Text(LocalizationManager.localizedString("ABOUT", languageCode: languageCode))) {
                    HStack {
                        Text("RemindMe v1.0")
                        Spacer()
                    }
                    HStack {
                        Text(LocalizationManager.localizedString("Created by Sefa Sarikaya", languageCode: languageCode))
                        Spacer()
                    }
                }
            }
            .navigationTitle(LocalizationManager.localizedString("Settings", languageCode: languageCode))
        }
        .onChange(of: colorScheme) { newValue in
            // Update the app's color scheme
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            window?.overrideUserInterfaceStyle = {
                switch newValue {
                case 0: return .unspecified  // System
                case 1: return .light
                case 2: return .dark
                default: return .unspecified
                }
            }()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}