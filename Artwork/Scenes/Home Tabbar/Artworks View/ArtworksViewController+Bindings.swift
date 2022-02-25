//
//  ArtworksViewController+Bindings.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import ReactiveCocoa
import UIKit

extension ArtworksViewController {

    func setUpBindings() {
        setUpNavigationSwipeToBackGesture()

        tblView.refreshControl?.reactive.controlEvents(.valueChanged)
            .observeValues { [weak self] _ in
                self?.viewModel.inputs.refreshArtworks()
            }

        viewModel.outputs.showAlertApiErrorMessage.signal
            .observe(on: Constants.mainScheduler)
            .skipNil()
            .observeValues { [weak self] errorMessage in
                self?.presentAlertMessage(errorMessage)
            }

        viewModel.outputs.artworksTableReload.signal
            .observe(on: Constants.mainScheduler)
            .observeValues { [weak self] _ in
                if self?.tblView.refreshControl?.isRefreshing == true {
                    self?.tblView.refreshControl?.endRefreshing()
                }
                self?.tblView.reloadData()
            }

        viewModel.outputs.openDetailForSelectedArtwork.signal
            .observe(on: Constants.mainScheduler)
            .skipNil()
            .observeValues { [weak self] artwork, moreArtwork in
                guard let self = self else { return }
                self.delegate?.artworksViewControllerOpenDetailForSelectedArtwork(self,
                                                                                  artwork: artwork,
                                                                                  moreArtworks: moreArtwork)
            }

        viewModel.outputs.featuredArtworksTableReload.signal
            .observe(on: Constants.mainScheduler)
            .observeValues { [weak self] _ in
                let featuredArtworks = self?.viewModel.outputs.featuredArtworks.value ?? []
                self?.featuredView.setArtworks(featuredArtworks)
            }

        viewModel.inputs.viewDidLoad()
    }

    @objc func editButtonDidClick() {
        tblView.setEditing(!tblView.isEditing, animated: true)
    }
}

extension ArtworksViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        let isRootVc = viewController == navigationController.rootViewController
        navigationController.interactivePopGestureRecognizer?.isEnabled = !isRootVc
    }

    func setUpNavigationSwipeToBackGesture() {
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}

extension ArtworksViewController: FeaturedArtworksViewDelegate {
    func featuredArtworksView(_ source: FeaturedArtworksView, didSelectArtwork artwork: Artwork) {
        delegate?.artworksViewControllerOpenDetailForSelectedArtwork(self,
                                                                     artwork: artwork,
                                                                     moreArtworks: [])
    }
}
