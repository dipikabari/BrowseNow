//
//  GetMoviesUseCaseImpl.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation
import PromiseKit

protocol GetMoviesUseCase {
    func execute(query: String, page: Int) -> Promise<[Movie]>
    func fetchTopRated(page: Int) -> Promise<[Movie]>
}

final class GetMoviesUseCaseImpl: GetMoviesUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(query: String, page: Int) -> Promise<[Movie]> {
        return repository.searchMovies(query: query, page: page)
    }
    
    func fetchTopRated(page: Int) -> Promise<[Movie]> {
        return repository.fetchTopRatedMovies(page: page)
    }
}
