//
//  TestDownloader.swift
//  EarthquakesTests
//
//  Created by SY L on 1/16/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testQuakesData
    }
}

