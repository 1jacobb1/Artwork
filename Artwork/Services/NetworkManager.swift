//
//  NetworkManager.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import Moya
import ReactiveSwift

struct NetworkManager: Networkable {
    let provider = MoyaProvider<ArtworkAPI>(plugins: [NetworkLoggerPlugin()])
    static let environment: APIEnvironment = .production

    func getArtworks(page: Int) -> SignalProducer<DataListResponse<Artwork>, MoyaError> {
        provider.reactive
            .request(.artworks(parameters: ["page": page]))
            .filterSuccessfulStatusCodes()
            .compactMap { response -> DataListResponse<Artwork>? in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try? decoder.decode(DataListResponse<Artwork>.self, from: response.data)
            }
    }
}
