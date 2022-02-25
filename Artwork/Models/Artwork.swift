//
//  Artwork.swift
//  Artwork
//
//  Created by Jacob on 2/22/22.
//

import Foundation

struct Artwork: Codable {
    var id: Int?
    var apiLink: String?
    var title: String?
    var hasNotBeenViewedMuch: Bool?
    var dateDisplay: String?
    var artistDisplay: String?
    var placeOfOrigin: String?
    var dimensions: String?
    var publicationHistory: String?
    var exhibitionHistory: String?
    var artistId: Int?
    var artistTitle: String?
    var imageId: String?

    enum CodingKeys: String, CodingKey {
        case id, apiLink, title,
             hasNotBeenViewedMuch, dateDisplay,
             artistDisplay, placeOfOrigin, dimensions,
             publicationHistory, exhibitionHistory,
             artistId, artistTitle, imageId
    }

    init(apiLink: String?, title: String?, isMostViewed: Bool,
         dateDisplay: String?, artistDisplay: String?, placeOfOrigin: String?,
         dimensions: String?, publicationHistory: String?, exhibitionHistory: String?,
         artistId: Int, artistTitle: String?, imageId: String) {
        id = 0
        self.apiLink = apiLink
        self.title = title
        self.hasNotBeenViewedMuch = isMostViewed
        self.dateDisplay = dateDisplay
        self.artistDisplay = artistDisplay
        self.placeOfOrigin = placeOfOrigin
        self.dimensions = dimensions
        self.publicationHistory = publicationHistory
        self.exhibitionHistory = exhibitionHistory
        self.artistId = artistId
        self.artistTitle = artistTitle
        self.imageId = imageId
    }

    var imageUrl: URL? {
        if let imageId = imageId {
            let urlFromImageId = "https://www.artic.edu/iiif/2/\(imageId)/full/843,/0/default.jpg"
            return URL(string: urlFromImageId)
        }
        return nil
    }

    var descriptionDisplay: String {
        var text = ""
        if let exhibitionHistory = exhibitionHistory {
            text = exhibitionHistory
        }

        if let publicationHistory = publicationHistory {
            text += "\n\n\(publicationHistory)"
        }

        return text
    }
}

extension Artwork {
    static let sample = Artwork(apiLink: nil,
                                title: "Yellow Submarine",
                                isMostViewed: true,
                                dateDisplay: "Test",
                                artistDisplay: "Artist Display",
                                placeOfOrigin: "United States of America",
                                dimensions: "200x100",
                                publicationHistory: nil,
                                exhibitionHistory: nil,
                                artistId: 0,
                                artistTitle: nil,
                                imageId: "4e074d70-4424-331b-ec89-0776a45d6825")
}
