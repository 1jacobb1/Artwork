//
//  DataListResponse.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import Foundation

struct DataListResponse<T: Codable>: Codable {
    var pagination: Pagination?
    var data: [T]

    enum CodingKeys: String, CodingKey {
        case pagination, data
    }
}
