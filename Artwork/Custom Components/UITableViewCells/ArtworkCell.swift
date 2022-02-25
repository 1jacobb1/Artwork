//
//  ArtworkCell.swift
//  Artwork
//
//  Created by Jacob on 2/24/22.
//

import UIKit

class ArtworkCell: UITableViewCell, ReusableView {

    // MARK: - UI
    var roundedShadowView = UIView()
    var artworkView = ArtworkView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { deinitLog() }

    func setArtwork(_ artwork: Artwork) {
        artworkView.setArtwork(artwork)
    }
}

extension ArtworkCell {

    func setUpCell() {
        setUpRoundedShadowView()
        setUpArtworkView()
    }

    private func setUpRoundedShadowView() {
        roundedShadowView.layer.backgroundColor = UIColor.clear.cgColor
        roundedShadowView.layer.shadowColor = UIColor.black.cgColor
        roundedShadowView.layer.shadowOffset = .init(width: 0, height: 1)
        roundedShadowView.layer.shadowOpacity = 0.2
        roundedShadowView.layer.shadowRadius = 4

        contentView.addSubview(roundedShadowView)

        roundedShadowView.snp.makeConstraints { make in
            let topBottom = 10, leftRight = 15
            make.top.bottom.equalToSuperview().inset(topBottom)
            make.left.right.equalToSuperview().inset(leftRight)
        }
    }

    private func setUpArtworkView() {
        artworkView.clipsToBounds = true
        artworkView.backgroundColor = .white
        artworkView.layer.cornerRadius = 20
        artworkView.layer.masksToBounds = true

        roundedShadowView.addSubview(artworkView)

        artworkView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
