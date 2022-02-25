//
//  UIView+Extensions.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import Foundation
import SnapKit

// https://github.com/SnapKit/SnapKit/issues/448#issuecomment-342513599
extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        #endif
        return self.snp
    }

    func deinitLog() { debugPrint("Deinit \(String(describing: self))") }

    /// Link: https://stackoverflow.com/a/47038575
    func addShadow(offset: CGSize,
                   color: UIColor = .black,
                   opacity: Float = 0.5,
                   radius: CGFloat = 5.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}
