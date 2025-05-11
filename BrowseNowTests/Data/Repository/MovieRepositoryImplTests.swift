//
//  MovieRepositoryImplTests.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 11/05/2025.
//

import XCTest
@testable import BrowseNow

final class MovieRepositoryImplTests: XCTestCase {
    var mockClient: MockNetworkClient!
    var service: MovieServiceImpl!
    var repository: MovieRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        mockClient = MockNetworkClient()
        service = MovieServiceImpl(client: mockClient)
        repository = MovieRepositoryImpl(service: service)
    }
    
    func testSearchMovies_mapsCorrectly() {
        mockClient.response = MovieResponseDTO(results: [sampleMovieDTO])

        let expectation = expectation(description: "Maps correctly to [Movie]")

        repository.searchMovies(query: "test", page: 1).done { movies in
            XCTAssertEqual(movies, [expectedMovie])
            expectation.fulfill()
        }.catch { _ in
            XCTFail("Expected success")
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchTopRatedMovies_propagatesError() {
        mockClient.error = NetworkError.invalidURL

        let expectation = expectation(description: "Should propagate service error")

        repository.fetchTopRatedMovies(page: 1).done { _ in
            XCTFail("Expected error")
        }.catch { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
