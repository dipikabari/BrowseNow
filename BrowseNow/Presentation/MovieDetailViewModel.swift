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
        String(format: Constants.ratingformat, movie.voteAverage)
    }

    var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Constants.localeIdentifier)
        formatter.dateFormat = Constants.dateFormat
        guard let date = formatter.date(from: movie.releaseDate) else { return movie.releaseDate }

        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    var languageDisplay: String {
        let locale = Locale(identifier: Constants.localeIdentifier)
        return locale.localizedString(forLanguageCode: movie.originalLanguage) ?? movie.originalLanguage.uppercased()
    }

    var overview: String { movie.overview }

    var backdropURL: URL? {
        guard let path = movie.fullBackdropURL else { return nil }
        return URL(string: path)
    }
}

extension MovieDetailViewModel {
    enum Constants {
        static let ratingformat = "%.1f"
        static let localeIdentifier = "en_GB"
        static let dateFormat = "yyyy-MM-dd"
    }
}
