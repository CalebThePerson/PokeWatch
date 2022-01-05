//
//  PokeWatchApp.swift
//  PokeWatch WatchKit Extension
//
//  Created by Caleb Wheeler on 1/4/22.
//

import SwiftUI

@main
struct PokeWatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
