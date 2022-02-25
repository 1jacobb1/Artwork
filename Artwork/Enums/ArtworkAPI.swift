//
//  ArtworkAPI.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import Moya

enum ArtworkAPI {
    case artworks(parameters: [String: Any])
}

extension ArtworkAPI: TargetType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.artic.edu/api/v1/"
        default: return ""
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }

    var path: String {
        switch self {
        case .artworks: return "artworks"
        }
    }

    var method: Method {
        switch self {
        case .artworks: return .get
        }
    }

    var task: Task {
        switch self {
        case .artworks(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? { ["Content-Type": "application/json", "Accept": "application/json"] }
}
