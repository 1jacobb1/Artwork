//
//  ArtworkDetailViewModel.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import ReactiveSwift

protocol ArtworkDetailViewModelInputs {
    func viewDidLoad()
    func shareButtonDidClick()
}

protocol ArtworkDetailViewModelOutputs {
    var artwork: MutableProperty<Artwork?> { get }
    var presentShareImageUrl: MutableProperty<URL?> { get }
    var moreArtworks: MutableProperty<[Artwork]> { get }
}

protocol ArtworkDetailViewModelTypes {
    var inputs: ArtworkDetailViewModelInputs { get }
    var outputs: ArtworkDetailViewModelOutputs { get }
}

class ArtworkDetailViewModel:
    ArtworkDetailViewModelTypes,
    ArtworkDetailViewModelInputs,
    ArtworkDetailViewModelOutputs {

    var inputs: ArtworkDetailViewModelInputs { self }
    var outputs: ArtworkDetailViewModelOutputs { self }

    var artwork: MutableProperty<Artwork?>
    var presentShareImageUrl: MutableProperty<URL?>
    var moreArtworks: MutableProperty<[Artwork]>

    init(artwork: Artwork, moreArtworks: [Artwork], networkProvider: Networkable) {
        self.artwork = MutableProperty(artwork)
        presentShareImageUrl = MutableProperty(nil)
        self.moreArtworks = MutableProperty(moreArtworks)

        presentShareImageUrl <~ shareButtonDidClickProp.signal
            .map { artwork.imageUrl }

        viewDidLoadProp.signal
            .observeValues { [unowned self] _ in
                self.artwork.value = artwork
                self.moreArtworks.value = moreArtworks
            }
    }

    deinit { debugPrint("Deinit \(String(describing: self))") }

    private var viewDidLoadProp = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProp.value = ()
    }

    private var shareButtonDidClickProp = MutableProperty(())
    func shareButtonDidClick() {
        shareButtonDidClickProp.value = ()
    }
}
