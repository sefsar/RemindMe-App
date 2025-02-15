//
//  ContentView.swift
//  RemindMe
//
//  Created by Sefa Sarikaya
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("languageCode") private var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(LocalizationManager.localizedString("Home", languageCode: languageCode), 
                          systemImage: "house.fill")
                }
            
            RemindersView()
                .tabItem {
                    Label(LocalizationManager.localizedString("Reminders", languageCode: languageCode), 
                          systemImage: "bell.fill")
                }
            
            PersonsView()
                .tabItem {
                    Label(LocalizationManager.localizedString("Persons", languageCode: languageCode),
                          systemImage: "person.3.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label(LocalizationManager.localizedString("Settings", languageCode: languageCode), 
                          systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
