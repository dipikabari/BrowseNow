//
//  MovieDetailViewModelTests.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 10/05/2025.
//

import XCTest
@testable import BrowseNow

final class MovieDetailViewModelTests: XCTestCase {

    func testTitle_ReturnsCorrectTitle() {
        let movie = makeTestMovie(title: "MovieA")
        let viewModel = MovieDetailViewModel(movie: movie)
        XCTAssertEqual(viewModel.title, "MovieA")
    }

    func testFormattedRating_ReturnsCorrectFormat() {
        let movie = makeTestMovie(voteAverage: 7.456)
        let viewModel = MovieDetailViewModel(movie: movie)
        XCTAssertEqual(viewModel.formattedRating, "7.5")
    }

    func testFormattedReleaseDate_FormatsCorrectly() {
        let movie = makeTestMovie(releaseDate: "2023-12-25")
        let viewModel = MovieDetailViewModel(movie: movie)
        XCTAssertEqual(viewModel.formattedReleaseDate, "25 December 2023")
    }

    func testFormattedReleaseDate_ReturnsFallbackOnInvalidDate() {
        let movie = makeTestMovie(releaseDate: "Invalid-Date")
        let viewModel = MovieDetailViewModel(movie: movie)
        XCTAssertEqual(viewModel.formattedReleaseDate, "Invalid-Date")
    }
    
    func testLanguageDisplay_ReturnsLocalizedLanguage() {
        let movie = makeTestMovie(originalLanguage: "fr")
        let viewModel = MovieDetailViewModel(movie: movie)
        XCTAssertEqual(viewModel.languageDisplay, "French")
    }

    func testOverview_ReturnsCorrectOverview() {
        let movie = makeTestMovie(overview: "This is a test overview.")
        let viewModel = MovieDetailViewModel(movie: movie)
        XCTAssertEqual(viewModel.overview, "This is a test overview.")
    }

    func testBackdropURL_ReturnsCorrectURL() {
        let movie = makeTestMovie(backdropPath: "/backdrop.jpg")
        let viewModel = MovieDetailViewModel(movie: movie)
        XCTAssertEqual(viewModel.backdropURL?.absoluteString, "https://image.tmdb.org/t/p/w780/backdrop.jpg")
    }
    
    func testBackdropURL_ReturnsNilWhenPathIsNil() {
        let movie = makeTestMovie(backdropPath: nil)
        let viewModel = MovieDetailViewModel(movie: movie)
        XCTAssertNil(viewModel.backdropURL)
    }
    
    func makeTestMovie(
        id: Int = 1,
        title: String = "Test Title",
        overview: String = "Test overview",
        releaseDate: String = "2023-10-15",
        originalLanguage: String = "en",
        posterPath : String? = "/poster1.jpg",
        backdropPath: String? = "/backdrop1.jpg",
        voteAverage: Double = 8.7,
    ) -> Movie {
        return Movie(
            id: id,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            originalLanguage: originalLanguage,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
        )
    }
}
