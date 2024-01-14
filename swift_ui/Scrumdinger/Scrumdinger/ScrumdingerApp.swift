//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by SY L on 1/14/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            ScrumView(scrums: $scrums)
        }
    }
}
