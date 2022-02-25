//
//  UIImageView+Extensions.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import UIKit
import SDWebImage

extension UIImageView {
    func displayImageUrl(_ url: URL, placeholderImage: UIImage? = .systemExclamationmarkIcloudFill) {
        sd_setImage(with: url,
                    placeholderImage: placeholderImage,
                    options: .progressiveDownload
        ) { [weak self] imageResult, _, _, _ in
            self?.image = imageResult != nil ? imageResult : placeholderImage
        }
    }
}


