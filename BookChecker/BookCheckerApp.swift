//
//  BookCheckerApp.swift
//  BookChecker
//
//  Created by Adam Herman on 08/02/2026.
//

import SwiftUI
import SwiftData

@main
struct BookCheckerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
