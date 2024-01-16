//
//  EKEventStore+AsyncFetch.swift
//  Today
//
//  Created by SY L on 1/16/24.
//

import Foundation

import EventKit
import Foundation

extension EKEventStore {
    func reminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        try await withCheckedThrowingContinuation{ contiuation in
            fetchReminders(matching: predicate){ reminders in
                if let reminders {
                    contiuation.resume(returning: reminders)
                } else {
                    contiuation.resume(throwing: TodayError.faildReadingReminders)
                }
            }
        }
    }
}
