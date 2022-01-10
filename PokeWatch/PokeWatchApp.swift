//
//  PokeWatchApp.swift
//  PokeWatch
//
//  Created by Caleb Wheeler on 1/4/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct PokeWatchApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let viewModel = SignUpViewModel()
            SignUp()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        return true
    }
}
