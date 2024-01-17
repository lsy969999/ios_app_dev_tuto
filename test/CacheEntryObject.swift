//
//  CacheEntryObject.swift
//  Earthquakes
//
//  Created by SY L on 1/17/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<QuakeLocation, Error>)
    case ready(QuakeLocation)
}
