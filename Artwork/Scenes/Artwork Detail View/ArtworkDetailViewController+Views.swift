//
//  ArtworkDetailViewController+Views.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import UIKit

extension ArtworkDetailViewController {

    func setUpScene() {
        view.backgroundColor = .white
        configureNavigationItem()
        setUpScrollView()
        setUpRoundedShadowView()
        setUpArtDisplayImageView()
        setUpTitleLabel()
        setUpArtistLabel()
        setUpDescrtiptionLabel()
        setUpMoreArtworkView()
    }

    private func configureNavigationItem() {
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.rightBarButtonItem = shareButtonItem
    }

    private func setUpScrollView() {
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setUpRoundedShadowView() {
        roundedShadowView.layer.backgroundColor = UIColor.clear.cgColor
        roundedShadowView.layer.shadowColor = UIColor.black.cgColor
        roundedShadowView.layer.shadowOffset = .init(width: 0, height: 1)
        roundedShadowView.layer.shadowOpacity = 0.2
        roundedShadowView.layer.shadowRadius = 4

        scrollView.addSubview(roundedShadowView)

        roundedShadowView.snp.makeConstraints { make in
            let top = 20, height = 280, width = 350
            make.top.equalToSuperview().offset(top)
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpArtDisplayImageView() {
        artDisplayImgView.contentMode = .scaleAspectFill
        artDisplayImgView.layer.cornerRadius = 20

        artDisplayImgView.clipsToBounds = true
        artDisplayImgView.backgroundColor = .white
        artDisplayImgView.layer.masksToBounds = true

        roundedShadowView.addSubview(artDisplayImgView)

        artDisplayImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setUpTitleLabel() {
        titleLbl.font = .boldSystemFont(ofSize: 20)
        titleLbl.numberOfLines = 0

        scrollView.addSubview(titleLbl)

        titleLbl.snp.makeConstraints { make in
            let top = 40, leftRight = 20
            make.top.equalTo(roundedShadowView.snp.bottom).offset(top)
            make.left.right.equalTo(view).inset(leftRight)
        }
    }

    private func setUpArtistLabel() {
        artistLbl.textColor = .lightGray
        artistLbl.numberOfLines = 0

        scrollView.addSubview(artistLbl)

        artistLbl.snp.makeConstraints { make in
            let top = 5
            make.top.equalTo(titleLbl.snp.bottom).offset(top)
            make.left.right.equalTo(titleLbl)
        }
    }

    private func setUpDescrtiptionLabel() {
        descriptionLbl.numberOfLines = 0

        scrollView.addSubview(descriptionLbl)

        descriptionLbl.snp.makeConstraints { make in
            let top = 15
            make.top.equalTo(artistLbl.snp.bottom).offset(top)
            make.left.right.equalTo(artistLbl)
        }
    }

    private func setUpMoreArtworkView() {
        moreArtworkView.delegate = self

        scrollView.addSubview(moreArtworkView)

        moreArtworkView.snp.makeConstraints { make in
            let top = 20
            make.top.equalTo(descriptionLbl.snp.bottom).offset(top)
            make.left.right.equalTo(view)
            make.bottom.equalToSuperview()
        }
    }
}
