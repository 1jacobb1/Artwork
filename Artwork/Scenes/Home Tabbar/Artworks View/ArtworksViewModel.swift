//
//  ArtworksViewModel.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import ReactiveSwift
import Foundation

protocol ArtworksViewModelInputs {
    func viewDidLoad()
    func refreshArtworks()
    func loadMoreArtworks()
    func tableViewDidSelectArtwork(artwork: Artwork)
    func tableViewMoveArtwork(from indexPath: IndexPath, to indexPath: IndexPath)
}

struct GroupedArtwork {
    var artworks: [Artwork]
    var artistId: Int
}

protocol ArtworksViewModelOutputs {
    var artworks: MutableProperty<[Artwork]> { get }
    var artworksInGroup: MutableProperty<[GroupedArtwork]> { get }
    var artworksTableReload: MutableProperty<Void> { get }
    var openDetailForSelectedArtwork: MutableProperty<(artwork: Artwork, moreArtworks: [Artwork])?> { get }
    var featuredArtworks: MutableProperty<[Artwork]> { get }
    var featuredArtworksTableReload: MutableProperty<Void> { get }
    var showAlertApiErrorMessage: MutableProperty<String?> { get }
}

protocol ArtworksViewModelTypes {
    var inputs: ArtworksViewModelInputs { get }
    var outputs: ArtworksViewModelOutputs { get }
}

class ArtworksViewModel:
    ArtworksViewModelTypes,
    ArtworksViewModelInputs,
    ArtworksViewModelOutputs {

    var inputs: ArtworksViewModelInputs { self }
    var outputs: ArtworksViewModelOutputs { self }

    var artworks: MutableProperty<[Artwork]>
    var artworksInGroup: MutableProperty<[GroupedArtwork]>
    var artworksTableReload: MutableProperty<Void>
    var openDetailForSelectedArtwork: MutableProperty<(artwork: Artwork, moreArtworks: [Artwork])?>
    var featuredArtworks: MutableProperty<[Artwork]>
    var featuredArtworksTableReload: MutableProperty<Void>
    var showAlertApiErrorMessage: MutableProperty<String?>

    internal var pagination = Pagination(totalPages: 0, currentPage: 0)
    internal let networkProvider: Networkable

    init(networkProvider: Networkable) {
        self.networkProvider = networkProvider
        artworks = MutableProperty([])
        artworksInGroup = MutableProperty([])
        artworksTableReload = MutableProperty(())
        openDetailForSelectedArtwork = MutableProperty(nil)
        featuredArtworks = MutableProperty([])
        featuredArtworksTableReload = MutableProperty(())
        showAlertApiErrorMessage = MutableProperty(nil)

        viewDidLoadProp.signal
            .observeValues { [unowned self] _ in
                self.refreshArtworks()
            }

        refreshArtworksProp.signal
            .observeValues { [unowned self] _ in
                self.refreshArtworksRequest()
            }

        loadMoreArtworksProp.signal
            .observeValues { [unowned self] _ in
                let page = pagination.currentPage + 1
                self.loadMoreArtworksRequest(page: page)
            }

        openDetailForSelectedArtwork <~ tableViewDidSelectedArtworkProp
            .signal
            .skipNil()
            .map { [unowned self] artwork -> (Artwork, [Artwork]) in
                let moreArtworks = self.artworksInGroup.value
                    .first(where: { $0.artistId == artwork.artistId })?
                    .artworks
                    .filter { $0.id != artwork.id } ?? []
                return (artwork, moreArtworks)
            }

        tableViewMoveArtworkProp.signal
            .skipNil()
            .observeValues { [unowned self] sourceIndexPath, destinationIndexPath in
                self.processArtworkMoving(sourceIndexPath: sourceIndexPath,
                                          destinationIndexPath: destinationIndexPath)
            }
    }

    deinit { debugPrint("Deinit \(String(describing: self))") }

    private var viewDidLoadProp = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProp.value = ()
    }

    private var refreshArtworksProp = MutableProperty(())
    func refreshArtworks() {
        refreshArtworksProp.value = ()
    }

    private var loadMoreArtworksProp = MutableProperty(())
    func loadMoreArtworks() {
        loadMoreArtworksProp.value = ()
    }

    private var tableViewDidSelectedArtworkProp = MutableProperty<Artwork?>(nil)
    func tableViewDidSelectArtwork(artwork: Artwork) {
        tableViewDidSelectedArtworkProp.value = artwork
    }

    private var tableViewMoveArtworkProp = MutableProperty<(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)?>(nil)
    func tableViewMoveArtwork(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tableViewMoveArtworkProp.value = (sourceIndexPath, destinationIndexPath)
    }

    private func refreshArtworksRequest() {
        getArtworksRequestInPage(1)
    }

    private func endGetArtworkRequest() {
        if getArtworkRequestCancellable != nil {
            getArtworkRequestCancellable?.dispose()
            getArtworkRequestCancellable = nil
        }
    }

    private func clearArtworks() {
        artworks.value = []
    }

    private func addArtworks(_ artworks: [Artwork]) {
        if self.artworks.value.isEmpty {
            self.artworks.value = artworks
        } else {
            var currentArtworks = self.artworks.value
            currentArtworks.append(contentsOf: artworks)
            self.artworks.value = currentArtworks
        }
    }

    private func loadMoreArtworksRequest(page: Int) {
        getArtworksRequestInPage(page)
    }

    private var getArtworkRequestCancellable: Disposable?
    private func getArtworksRequestInPage(_ page: Int) {
        if getArtworkRequestCancellable != nil { return }
        getArtworkRequestCancellable = networkProvider.getArtworks(page: page)
            .start(on: Constants.backgroundScheduler)
            .startWithResult { [weak self] result in
                switch result {
                case .success(let response):
                    if page == 1 {
                        self?.clearArtworks()
                    }
                    if let pagination = response.pagination {
                        self?.pagination = pagination
                    }
                    self?.addArtworks(response.data)
                    self?.processFeaturedArtworkList()
                    self?.processArtworkGrouping(artworks: response.data)
                    break
                case .failure(let moyaError):
                    self?.showAlertApiErrorMessage.value = moyaError.localizedDescription
                    break
                }
                self?.artworksTableReload.value = ()
                self?.endGetArtworkRequest()
            }
    }

    private func processArtworkGrouping(artworks: [Artwork]) {
        if artworksInGroup.value.isEmpty {
            artworksInGroup.value = Dictionary(grouping: self.artworks.value, by: { $0.artistId })
                .map { key, value -> GroupedArtwork in
                    GroupedArtwork(artworks: value, artistId: key ?? 0)
                }
        } else {
            var groupedArtworks = artworksInGroup.value
            artworks.forEach { artwork in
                if let index = groupedArtworks.firstIndex(where: { $0.artistId == artwork.artistId }) {
                    if !groupedArtworks[index].artworks.contains(where: { $0.id == artwork.id }) {
                        groupedArtworks[index].artworks.append(artwork)
                    }
                } else {
                    groupedArtworks.append(GroupedArtwork(artworks: [artwork], artistId: artwork.artistId ?? 0))
                }
            }
            artworksInGroup.value = groupedArtworks
        }
    }

    private func processArtworkMoving(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        guard let artwork = artworksInGroup.value[safe: sourceIndexPath.section]?
                .artworks[safe: sourceIndexPath.row] else { return }

        if var groupedArtwork = artworksInGroup.value[safe: sourceIndexPath.section] {
            groupedArtwork.artworks.remove(at: sourceIndexPath.row)
            artworksInGroup.value[sourceIndexPath.section] = groupedArtwork
        }

        if var groupedArtwork = artworksInGroup.value[safe: destinationIndexPath.section] {
            groupedArtwork.artworks.insert(artwork, at: destinationIndexPath.row)
            artworksInGroup.value[destinationIndexPath.section] = groupedArtwork
        }
    }

    private func processFeaturedArtworkList() {
        var artworksPerArtist: [Artwork] = []
        artworks.value.forEach { artwork in
            if !artworksPerArtist.contains(where: { $0.artistId == artwork.artistId }) {
                var modifiedArtwork = artwork
                modifiedArtwork.exhibitionHistory = nil
                modifiedArtwork.publicationHistory = nil
                artworksPerArtist.append(modifiedArtwork)
            }
        }
        featuredArtworks.value = artworksPerArtist
        featuredArtworksTableReload.value = ()
    }
}
