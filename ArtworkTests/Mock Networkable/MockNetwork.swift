//
//  MockNetwork.swift
//  ArtworkTests
//
//  Created by Jacob on 2/25/22.
//

@testable import Artwork
import Moya
import ReactiveSwift

struct MockNetwork: Networkable {
    func getArtworks(page: Int) -> SignalProducer<DataListResponse<Artwork>, MoyaError> {
        SignalProducer<DataListResponse<Artwork>, MoyaError> { signal, _ in
            var artworks: [Artwork] = []
            for i in 1..<30 {
                var artwork = Artwork.sample
                artwork.id = i
                artworks.append(artwork)
            }
            let pagination = Pagination(totalPages: 100, currentPage: 1)
            let response = DataListResponse(pagination: pagination, data: artworks)
            signal.send(value: response)
        }
    }
}
