//
//  ArtworkView.swift
//  Artwork
//
//  Created by Jacob on 2/24/22.
//

import UIKit

class ArtworkView: UIView {

    // MARK: - UI
    var artImgView = UIImageView()
    var infoContainerView = UIView()
    var artworkTitleLbl = UILabel()
    var artistLbl = UILabel()
    var historyLbl = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { deinitLog() }

    func setArtwork(_ artwork: Artwork) {
        if let imageUrl = artwork.imageUrl {
            artImgView.displayImageUrl(imageUrl)
        }
        artworkTitleLbl.text = artwork.title
        artistLbl.text = artwork.artistTitle
        historyLbl.text = artwork.publicationHistory
    }

    func setUpView() {
        setUpArtImageView()
        setUpInfoContainerView()
        setUpArtworkTitleLabel()
        setUpArtistLabel()
        setUpHistoryLabel()
    }

    private func setUpArtImageView() {
        artImgView.contentMode = .scaleAspectFill
        artImgView.image = .systemExclamationmarkIcloudFill

        addSubview(artImgView)

        artImgView.snp.makeConstraints { make in
            let height = 300
            make.top.left.right.equalToSuperview()
            make.height.equalTo(height)
        }
    }

    private func setUpInfoContainerView() {
        infoContainerView.backgroundColor = .white

        addSubview(infoContainerView)

        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(artImgView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func setUpArtworkTitleLabel() {
        artworkTitleLbl.font = .boldSystemFont(ofSize: 20)

        infoContainerView.addSubview(artworkTitleLbl)

        artworkTitleLbl.snp.makeConstraints { make in
            let top = 5, leftRight = 15
            make.top.equalToSuperview().offset(top)
            make.left.right.equalToSuperview().inset(leftRight)
        }
    }

    private func setUpArtistLabel() {
        artistLbl.textColor = .orange
        artistLbl.font = .systemFont(ofSize: 14)

        infoContainerView.addSubview(artistLbl)

        artistLbl.snp.makeConstraints { make in
            let top = 3
            make.top.equalTo(artworkTitleLbl.snp.bottom).offset(top)
            make.left.right.equalTo(artworkTitleLbl)
        }
    }

    private func setUpHistoryLabel() {
        historyLbl.font = .systemFont(ofSize: 14)
        historyLbl.numberOfLines = 2

        infoContainerView.addSubview(historyLbl)

        historyLbl.snp.makeConstraints { make in
            let bottom = 10, top = 3
            make.top.equalTo(artistLbl.snp.bottom).offset(top)
            make.left.right.equalTo(artistLbl)
            make.bottom.equalToSuperview().inset(bottom)
        }
    }
}
