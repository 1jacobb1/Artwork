//
//  Networkable.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import Moya
import ReactiveSwift

protocol Networkable {
    func getArtworks(page: Int) -> SignalProducer<DataListResponse<Artwork>, MoyaError>
}
