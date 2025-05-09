//
//  MovieSearchViewModel.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation
import PromiseKit

protocol MovieSearchViewModelProtocol {
    var onMoviesFetched: (([Movie]) -> Void)? { get set }
    var onSearchError: ((String) -> Void)? { get set }
    var currentPage: Int { get set }
    
    func search(query: String)
    func loadInitialMovies()
    func loadMore()
}

final class MovieSearchViewModel: MovieSearchViewModelProtocol {
    private let useCase: GetMoviesUseCase
    private var currentQuery: String?
    
    private var isLoading = false
    
    var currentPage = 1
    var onMoviesFetched: (([Movie]) -> Void)?
    var onSearchError: ((String) -> Void)?
    
    init(useCase: GetMoviesUseCase) {
        self.useCase = useCase
    }
    
    func loadInitialMovies() {
        currentQuery = nil
        currentPage = 1
        fetchMovies()
    }
    
    func search(query: String) {
        currentQuery = query
        currentPage = 1
        fetchMovies()
    }

    func loadMore() {
        guard !isLoading else { return }
        currentPage += 1
        fetchMovies(append: true)
    }
    
    private func fetchMovies(append: Bool = false) {
        isLoading = true

        let fetchPromise: Promise<[Movie]> = {
            if let query = currentQuery, !query.isEmpty {
                return useCase.execute(query: query, page: currentPage)
            } else {
                return useCase.fetchTopRated(page: currentPage)
            }
        }()

        fetchPromise.done { [weak self] movies in
            Logger.log("Parsed \(movies.count) movies", level: .info)
            self?.isLoading = false
            
            if movies.isEmpty {
                self?.onSearchError?(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No movies found. Please try a different search."]) as! String)
            } else {
                self?.onMoviesFetched?(movies)
            }
        }.catch { [weak self] error in
            self?.isLoading = false
            self?.onSearchError?("Error: \(error.localizedDescription)")
            Logger.log("\(error.localizedDescription)", level: .error)
        }
    }
}
