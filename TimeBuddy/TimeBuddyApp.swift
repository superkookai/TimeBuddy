//
//  TimeBuddyApp.swift
//  TimeBuddy
//
//  Created by Weerawut Chaiyasomboon on 29/11/2567 BE.
//

import SwiftUI

@main
struct TimeBuddyApp: App {
    var body: some Scene {
        MenuBarExtra("Time Buddy", systemImage: "person.badge.clock.fill") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
    }
}

