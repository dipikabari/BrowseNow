//
//  MovieServiceImpl.swift
//  BrowseNow
//
//  Created by Dipika Bari on 08/05/2025.
//

import Foundation
import PromiseKit

protocol MovieService {
    func fetchMovies(query: String, page: Int) -> Promise<MovieResponseDTO>
    func fetchTopRated(page: Int) -> Promise<MovieResponseDTO>
}

final class MovieServiceImpl: MovieService {
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    func fetchMovies(query: String, page: Int) -> Promise<MovieResponseDTO> {
        guard let request = MovieEndpoint.search(query: query, page: page) else {
            return Promise(error: NetworkError.invalidURL)
        }
        return client.request(endPoint: request)
    }
    
    func fetchTopRated(page: Int) -> Promise<MovieResponseDTO> {
        guard let endPoint = MovieEndpoint.topRated(page: page) else {
            return Promise(error: NetworkError.invalidURL)
        }
        return client.request(endPoint: endPoint)
    }
}

