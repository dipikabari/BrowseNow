//
//  MockData.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 11/05/2025.
//

import Foundation
@testable import BrowseNow

let sampleMovieDTO = MovieDTO(
    id: 1,
    title: "Inception",
    overview: "A mind-bending thriller",
    release_date: "2010-07-16",
    original_language: "en",
    poster_path: "/poster.jpg",
    backdrop_path: "/backdrop.jpg",
    vote_average: 8.8
)

let sampleMovieResponseDTO = MovieResponseDTO(results: [sampleMovieDTO])

let expectedMovie = Movie(
    id: 1,
    title: "Inception",
    overview: "A mind-bending thriller",
    releaseDate: "2010-07-16",
    originalLanguage: "en",
    posterPath: "/poster.jpg",
    backdropPath: "/backdrop.jpg",
    voteAverage: 8.8
)
