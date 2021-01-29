//
//  BookCoreDataApp.swift
//  BookCoreData
//
//  Created by Екатерина Чернова on 29.01.2021.
//

import SwiftUI

@main
struct BookCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
