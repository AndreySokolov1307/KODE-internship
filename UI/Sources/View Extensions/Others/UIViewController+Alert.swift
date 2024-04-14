//
//  UIViewController+Alert.swift
//  UI
//
//  Created by Андрей Соколов on 14.04.2024.
//

import UIKit

public extension UIViewController {
    func presentAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
}
