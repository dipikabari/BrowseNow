//
//  MovieDetailViewModel.swift
//  BrowseNow
//
//  Created by Dipika Bari on 09/05/2025.
//

import Foundation

final class MovieDetailViewModel {
    private let movie: Movie
        
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String { movie.title }

    var formattedRating: String {
        String(format: "%.2f", movie.voteAverage)
    }

    var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: movie.releaseDate) else { return movie.releaseDate }

        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    var languageDisplay: String {
        let locale = Locale(identifier: "en_GB")
        return locale.localizedString(forLanguageCode: movie.originalLanguage) ?? movie.originalLanguage.uppercased()
    }

    var overview: String { movie.overview }
    var posterURL: URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    var backdropURL: URL? {
        guard let path = movie.backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(path)")
    }
}
