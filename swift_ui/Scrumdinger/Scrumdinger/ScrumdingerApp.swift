//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by SY L on 1/14/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    var body: some Scene {
        WindowGroup {
            ScrumView(scrums: $store.scrums){
                Task {
                    do {
                        try await store.save(scums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
