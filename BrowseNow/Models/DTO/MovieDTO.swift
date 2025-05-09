//
//  MovieDTO.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation

struct MovieResponseDTO: Codable {
    let results: [MovieDTO]
}

struct MovieDTO: Codable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let original_language: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
}
