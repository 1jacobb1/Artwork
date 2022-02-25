//
//  ArtworkDetailViewModelTests.swift
//  ArtworkTests
//
//  Created by Jacob on 2/25/22.
//

@testable import Artwork
import XCTest

class ArtworkDetailViewModelTests: XCTestCase {

    var viewModel: ArtworkDetailViewModel!

    override func setUp() {
        super.setUp()
        let moreArtworks = Array((1..<5).map { id -> Artwork in
            var artwork = Artwork.sample
            artwork.id = id
            return artwork
        })

        viewModel = ArtworkDetailViewModel(artwork: .sample,
                                           moreArtworks: moreArtworks,
                                           networkProvider: MockNetwork())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    /**
     Successful test for presenting share view
     */
    func testSuccessfulPresentShareView() {
        // Inputs
        viewModel.inputs.viewDidLoad()
        viewModel.inputs.shareButtonDidClick()

        // Assertions
        XCTAssertNotNil(viewModel.outputs.presentShareImageUrl.value)
    }

    /**
     Failing test for not calling the input shareButtonDidClick.
     */
    func testFailingPresentShareView() {
        // Inputs
        viewModel.inputs.viewDidLoad()

        // Assertions
        XCTAssertNil(viewModel.outputs.presentShareImageUrl.value)
    }
}
