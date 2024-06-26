//
//  Todo_AppApp.swift
//  Todo App
//
//  Created by Hưng Trần on 18/3/24.
//

import SwiftUI

@main
struct Todo_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
