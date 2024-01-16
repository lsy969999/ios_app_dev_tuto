//
//  Controller+Actions.swift
//  Today
//
//  Created by SY L on 1/16/24.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else {
            return
        }
        completeReminder(withId: id)
    }
    
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
