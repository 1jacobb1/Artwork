//
//  ApplicationCoordinator+ArtworkDetailViewControllerDelegate.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

extension ApplicationCoordinator: ArtworkDetailViewControllerDelegate {
    func artworkDetailViewControllerBackToArtworks(_ source: ArtworkDetailViewController) {
        guard let nav = source.navigationController else { return }
        nav.popViewController(animated: true)
    }

    func artworkDetailViewControllerOpenOtherArtworkDetail(_ source: ArtworkDetailViewController,
                                                           artwork: Artwork,
                                                           moreArtwork: [Artwork]) {
        displayArtworkDetail(artwork: artwork, moreArtworks: moreArtwork)
    }
}
