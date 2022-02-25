//
//  ArtworkDetailViewController+Bindings.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import Foundation
import UIKit

extension ArtworkDetailViewController {

    func setUpBindings() {

        viewModel.outputs.presentShareImageUrl
            .signal
            .skipNil()
            .observe(on: Constants.mainScheduler)
            .observeValues { [weak self] url in
                self?.presentShareImageUrl(url)
            }

        viewModel.outputs.artwork
            .signal
            .skipNil()
            .observe(on: Constants.mainScheduler)
            .observeValues { [weak self] artwork in
                self?.setArtworkDisplay(artwork: artwork)
            }

        viewModel.outputs.moreArtworks
            .signal
            .observe(on: Constants.mainScheduler)
            .observeValues { [weak self] moreArtwork in
                self?.moreArtworkView.setArtworks(moreArtwork)
            }

        viewModel.inputs.viewDidLoad()
    }

    @objc func didClickBackButtonItem() {
        delegate?.artworkDetailViewControllerBackToArtworks(self)
    }

    @objc func didClickShareButtonItem() {
        viewModel.inputs.shareButtonDidClick()
    }

    private func presentShareImageUrl(_ url: URL) {
        let activityItems = [url]
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = shareButtonItem.customView
        present(activityViewController, animated: true)
    }

    private func setArtworkDisplay(artwork: Artwork) {
        if let imageUrl = artwork.imageUrl {
            artDisplayImgView.displayImageUrl(imageUrl)
        }
        titleLbl.text = artwork.title
        artistLbl.text = artwork.artistTitle
        descriptionLbl.text = artwork.descriptionDisplay
    }
}

extension ArtworkDetailViewController: MoreArtworkViewDelegate {
    func moreArtworkViewDidSelectArtwork(_ source: MoreArtworkView,
                                         artwork: Artwork,
                                         moreArtwork: [Artwork]) {
        var artworks = moreArtwork
        if let artworkDetail = viewModel.outputs.artwork.value {
            artworks.append(artworkDetail)
        }
        delegate?.artworkDetailViewControllerOpenOtherArtworkDetail(self,
                                                                    artwork: artwork,
                                                                    moreArtwork: artworks)
    }
}
