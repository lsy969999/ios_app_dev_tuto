//
//  QuakesProvier.swift
//  Earthquakes
//
//  Created by SY L on 1/16/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

@MainActor
class QuakesProvier: ObservableObject {
    @Published var quakes: [Quake] = []
    
    let client: QuakeClient
    
    func fetchQuakes() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuakes(atOffsets offsets: IndexSet) {
        quakes.remove(atOffsets: offsets)
    }
    
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}
