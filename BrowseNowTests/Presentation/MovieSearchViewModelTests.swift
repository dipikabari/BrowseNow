//
//  MovieSearchViewModelTests.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 10/05/2025.
//

import XCTest
import PromiseKit
@testable import BrowseNow

final class MovieSearchViewModelTests: XCTestCase {

    var mockUseCase: MockGetMoviesUseCase!
    var viewModel: MovieSearchViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        mockUseCase = MockGetMoviesUseCase()
        viewModel = MovieSearchViewModel(useCase: mockUseCase)
    }

    func test_loadInitialMovies_fetchesTopRatedMovies() {
        let expectation = self.expectation(description: "Movies Fetched")
        let movies = [Movie(
            id: 1,
            title: "MovieA",
            overview: "Mock movieA",
            releaseDate: "2014-11-05",
            originalLanguage: "en",
            posterPath: "/poster1.jpg",
            backdropPath: "/backdrop1.jpg",
            voteAverage: 8.455)]
        
        mockUseCase.fetchTopRatedHandler = { _ in Promise.value(movies)}
        
        viewModel.onMoviesFetched = { fetched in
            XCTAssertEqual(fetched, movies)
            expectation.fulfill()
        }
        
        viewModel.loadInitialMovies()
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func test_search_success_returnsMovies() {
        let expectation = self.expectation(description: "Search successful")
        let movies = [Movie(
            id: 2,
            title: "MovieB",
            overview: "Mock movieB",
            releaseDate: "2014-11-05",
            originalLanguage: "en",
            posterPath: "/poster2.jpg",
            backdropPath: "/backdrop2.jpg",
            voteAverage: 7.25)]
        
        mockUseCase.executeHandler = { query, _ in
            XCTAssertEqual(query, "test")
            return Promise.value(movies)
        }

        viewModel.onMoviesFetched = { fetched in
            XCTAssertEqual(fetched, movies)
            expectation.fulfill()
        }

        viewModel.search(query: "test")
        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_search_failure_callsErrorHandler() {
        let expectation = self.expectation(description: "Search error")
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        
        mockUseCase.executeHandler = { _, _ in Promise(error: error) }

        viewModel.onSearchError = { errorMessage in
            XCTAssertTrue(errorMessage.contains("Error"))
            expectation.fulfill()
        }

        viewModel.search(query: "fail")
        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_loadMore_incrementsPage() {
        let firstPage = [Movie(
            id: 1,
            title: "MovieA",
            overview: "Mock movieA",
            releaseDate: "2014-11-05",
            originalLanguage: "en",
            posterPath: "/poster1.jpg",
            backdropPath: "/backdrop1.jpg",
            voteAverage: 8.455)]
        let secondPage = [Movie(
            id: 2,
            title: "MovieB",
            overview: "Mock movieB",
            releaseDate: "2014-11-05",
            originalLanguage: "en",
            posterPath: "/poster2.jpg",
            backdropPath: "/backdrop2.jpg",
            voteAverage: 7.25)]
        
        var callCount = 0
        mockUseCase.fetchTopRatedHandler = { page in
            callCount += 1
            return Promise.value(page == 1 ? firstPage : secondPage)
        }

        let expectation = self.expectation(description: "Load more")
        expectation.expectedFulfillmentCount = 2
        
        viewModel.onMoviesFetched = { _ in expectation.fulfill() }

        viewModel.loadInitialMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewModel.loadMore()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(self.viewModel.currentPage, 2)
        XCTAssertEqual(callCount, 2)
    }
    
}
