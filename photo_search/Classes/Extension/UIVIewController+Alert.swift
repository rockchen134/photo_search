//
//  UIVIewController+Alert.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/28.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func alert(_ title: String, message: String, confirmHandler: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: NSLocalizedString("confirm", comment: ""), style: .default) { (_) in
            confirmHandler()
        }
        
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
}

extension UIViewController: Alertable {}
