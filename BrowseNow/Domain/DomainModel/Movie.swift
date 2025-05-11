//
//  Movie.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation

struct Movie: Equatable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let originalLanguage: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
}

extension Movie {
    var fullPosterURL: String? {
        guard let path = posterPath else { return nil }
        return "\(APIConstants.posterImageBaseURLString)\(path)"
    }
    
    var fullBackdropURL: String? {
        guard let path = backdropPath else { return nil }
        return "\(APIConstants.backdropImageBaseURLString)\(path)"
    }
}

