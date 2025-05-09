//
//  MovieMapper.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation

struct MovieMapper {
    static func map(dto: MovieDTO) -> Movie {
        return Movie(
            id: dto.id,
            title: dto.title,
            overview: dto.overview,
            releaseDate: dto.release_date,
            posterPath: dto.poster_path,
            voteAverage: dto.vote_average)
    }
    
    static func mapList(dtoList : [MovieDTO]) -> [Movie] {
        return dtoList.map {
            map(dto: $0)
        }
    }
}
