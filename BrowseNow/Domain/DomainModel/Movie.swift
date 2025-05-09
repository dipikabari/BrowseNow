//
//  Movie.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let voteAverage: Double
}

extension Movie {
    var fullPosterURL: String? {
        guard let path = posterPath else { return nil }
        return "\(APIConstants.imageBaseURLString)\(path)"
    }
}

