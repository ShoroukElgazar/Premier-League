//
//  FootballApp.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/9/22.
//

import SwiftUI

@main
struct FootballApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PremierLeagueScreen.build()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
