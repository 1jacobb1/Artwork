//
//  Pagination.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

struct Pagination: Codable {
    var totalPages: Int
    var currentPage: Int

    var hasNext: Bool {
        currentPage < totalPages
    }

    enum CodingKeys: String, CodingKey {
        case totalPages, currentPage
    }
}
