//
//  SkeroCalcApp.swift
//  SkeroCalc Swift v1.1
//
//  Created by Kybl Enterprise 2025.
//

import SwiftUI

@main
struct SkeroCalcApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 400, height: 500)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.styleMask.remove([.resizable])
            window.setContentSize(NSSize(width: 400, height: 500))
        }
    }
}
