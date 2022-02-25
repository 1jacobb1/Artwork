//
//  ApplicationCoordinator.swift
//  Artwork
//
//  Created by Jacob on 2/22/22.
//

import UIKit

class ApplicationCoordinator: Coordinator {

    let window: UIWindow
    let networkProvider: Networkable

    init(window: UIWindow, networkProvider: Networkable) {
        self.window = window
        self.networkProvider = networkProvider
    }

    func start() {
        displayArtworkList()
    }

    func displayHomeTabbar() {
        let homeVm = HomeTabBarViewModel(networkProvider: networkProvider)
        let homeVc = HomeTabBarViewController(viewModel: homeVm)
        homeVc.artWorksVC.delegate = self
        window.rootViewController = homeVc
        window.makeKeyAndVisible()
    }

    func displayArtworkList() {
        let artworksVm = ArtworksViewModel(networkProvider: networkProvider)
        let artworksVc = ArtworksViewController(viewModel: artworksVm)
        artworksVc.delegate = self
        window.rootViewController = UINavigationController(rootViewController: artworksVc)
        window.makeKeyAndVisible()
    }

    func displayArtworkDetail(artwork: Artwork, moreArtworks: [Artwork]) {
        guard let nav = window.rootViewController as? UINavigationController else { return }
        let artworkDetailVm = ArtworkDetailViewModel(artwork: artwork,
                                                     moreArtworks: moreArtworks,
                                                     networkProvider: networkProvider)
        let artworkDetailVc = ArtworkDetailViewController(viewModel: artworkDetailVm)
        artworkDetailVc.delegate = self
        artworkDetailVc.hidesBottomBarWhenPushed = true
        nav.pushViewController(artworkDetailVc, animated: true)
    }
}
