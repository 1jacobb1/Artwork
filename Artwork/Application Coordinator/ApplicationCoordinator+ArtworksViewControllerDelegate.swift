//
//  ApplicationCoordinator+ArtworksViewControllerDelegate.swift
//  Artwork
//
//  Created by Jacob on 2/24/22.
//

extension ApplicationCoordinator: ArtworksViewControllerDelegate {
    func artworksViewControllerOpenDetailForSelectedArtwork(_ source: ArtworksViewController,
                                                            artwork: Artwork,
                                                            moreArtworks: [Artwork]) {
        displayArtworkDetail(artwork: artwork, moreArtworks: moreArtworks)
    }
}
