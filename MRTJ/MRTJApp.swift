//
//  MRTJApp.swift
//  MRTJ
//
//  Created by Jonathan Heriyanto on 19/07/23.
//

import SwiftUI

@main
struct MRTJApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
