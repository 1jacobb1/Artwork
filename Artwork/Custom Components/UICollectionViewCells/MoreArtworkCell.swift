//
//  MoreArtworkCell.swift
//  Artwork
//
//  Created by Jacob on 2/25/22.
//

import UIKit

class MoreArtworkCell: UICollectionViewCell, ReusableView {

    // MARK: - UI
    var roundedShadowView = UIView()
    var artworkImgView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { deinitLog() }

    func setCellWithArtwork(_ artwork: Artwork) {
        if let imageUrl = artwork.imageUrl {
            artworkImgView.displayImageUrl(imageUrl)
        }
    }

    func setUpCell() {
        setUpRoundedShadowView()
        setUpArtworkImageView()
    }

    private func setUpRoundedShadowView() {
        roundedShadowView.layer.backgroundColor = UIColor.clear.cgColor
        roundedShadowView.layer.shadowColor = UIColor.black.cgColor
        roundedShadowView.layer.shadowOffset = .init(width: 0, height: 1)
        roundedShadowView.layer.shadowOpacity = 0.2
        roundedShadowView.layer.shadowRadius = 8

        contentView.addSubview(roundedShadowView)

        roundedShadowView.snp.makeConstraints { make in
            let edgeSpacing = 5
            make.edges.equalToSuperview().inset(edgeSpacing)
        }
    }

    private func setUpArtworkImageView() {
        artworkImgView.contentMode = .scaleAspectFill
        artworkImgView.clipsToBounds = true
        artworkImgView.clipsToBounds = true
        artworkImgView.layer.cornerRadius = 8
        artworkImgView.layer.masksToBounds = true

        roundedShadowView.addSubview(artworkImgView)

        artworkImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
