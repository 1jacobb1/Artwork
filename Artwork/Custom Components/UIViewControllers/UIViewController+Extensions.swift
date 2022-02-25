//
//  UIViewController+Extensions.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import UIKit

extension UIViewController {
    func deinitLog() { debugPrint("Deinit \(String(describing: self))") }

    func presentAlertMessage(_ message: String) {
        let alertVc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertVc.addAction(okAction)
        present(alertVc, animated: true)
    }
}
