//
//  QuakeError.swift
//  Earthquakes-iOS
//
//  Created by SY L on 1/16/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

enum QuakeError: Error {
    case missingData
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Found and will discard a quake missing a valid code, magnitude, place, or time.", comment: "")
        }
    }
}
