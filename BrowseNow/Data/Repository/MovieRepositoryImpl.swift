//
//  MovieRepositoryImpl.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation
import PromiseKit

protocol MovieRepository {
    func searchMovies(query: String, page: Int) -> Promise<[Movie]>
    func fetchTopRatedMovies(page: Int) -> Promise<[Movie]>
}

final class MovieRepositoryImpl: MovieRepository {
    private let service: MovieService
    
    init(service: MovieService) {
        self.service = service
    }
    
    func searchMovies(query: String, page: Int) -> Promise<[Movie]> {
        return service.fetchMovies(query: query, page: page)
            .map{ responseDTO in
                MovieMapper.mapList(dtoList: responseDTO.results)
            }
    }
    
    func fetchTopRatedMovies(page: Int) -> Promise<[Movie]> {
        return service.fetchTopRated(page: page)
            .map { responseDTO in
                MovieMapper.mapList(dtoList: responseDTO.results)
            }
    }
}
