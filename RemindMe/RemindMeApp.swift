//
//  RemindMeApp.swift
//  RemindMe
//
//  Created by Sefa Sarikaya on 13.02.25.
//

import SwiftUI

@main
struct RemindMeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
