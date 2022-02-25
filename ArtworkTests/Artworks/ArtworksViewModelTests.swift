//
//  ArtworksViewModelTests.swift
//  ArtworkTests
//
//  Created by Jacob on 2/25/22.
//

import XCTest
@testable import Artwork

class ArtworksViewModelTests: XCTestCase {

    var viewModel: ArtworksViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ArtworksViewModel(networkProvider: MockNetwork())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    /**
     Successful test of refreshing artwork
     */
    func testSuccessfulArtworkRefresh() {
        // Inputs
        viewModel.inputs.loadMoreArtworks()

        // Outputs
        let artworks = viewModel.outputs.artworks.value

        DispatchQueue.global(qos: .background).async {
            // Assertions
            XCTAssertFalse(artworks.isEmpty)
        }
    }

    /**
     Failed test of not calling refresh artwork
     */
    func testFailingArtworkRefresh() {
        // Outputs
        let artworks = viewModel.outputs.artworks.value

        // Assertions
        XCTAssert(artworks.isEmpty)
    }

    /**
     Successful test of loading more artworks.
     */
    func testSuccessfulLoadMoreArtworks() {
        // Inputs
        viewModel.inputs.loadMoreArtworks()

        // Outputs
        let artworks = viewModel.outputs.artworks.value

        DispatchQueue.global(qos: .background).async {
            // Assertions
            XCTAssertFalse(artworks.isEmpty)
        }
    }

    /**
     Failing test of loading more artworks without calling load more.
     */
    func testFailingLoadMoreArtworks() {
        // Outputs
        let artworks = viewModel.outputs.artworks.value

        DispatchQueue.global(qos: .background).async {
            // Assertions
            XCTAssert(artworks.isEmpty)
        }
    }

    /**
     Successful test of opening the artwork detail from selected item.
     */
    func testSuccessfulOpenArtworkDetail() {
        // Inputs
        viewModel.inputs.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
            if let artwork = self.viewModel.outputs.artworks.value.first {
                self.viewModel.inputs.tableViewDidSelectArtwork(artwork: artwork)
            }

            // Assertions
            XCTAssertNotNil(self.viewModel.outputs.openDetailForSelectedArtwork.value)
        }
    }

    /**
     Successful test of loading the featured artworks.
     */
    func testSuccessfulLoadOfFeaturedArtworks() {
        // Inputs
        viewModel.inputs.viewDidLoad()

        DispatchQueue.global(qos: .background).async {
            // Assertions
            XCTAssertFalse(self.viewModel.outputs.featuredArtworks.value.isEmpty)
        }
    }

    /**
     Failing test of loading the featured artworks without calling the viewDidLoad.
     */
    func testFailingLoadOfFeaturedArtworks() {
        DispatchQueue.global(qos: .background).async {
            // Assertions
            XCTAssert(self.viewModel.outputs.featuredArtworks.value.isEmpty)
        }
    }
}
