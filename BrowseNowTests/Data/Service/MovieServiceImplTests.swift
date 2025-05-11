//
//  MovieServiceImplTests.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 11/05/2025.
//

import XCTest
@testable import BrowseNow

final class MovieServiceImplTests: XCTestCase {
    var mockClient: MockNetworkClient!
    var service: MovieServiceImpl!

    override func setUp() {
        super.setUp()
        mockClient = MockNetworkClient()
        service = MovieServiceImpl(client: mockClient)
    }

    func testFetchMovies_success() {
        let response = MovieResponseDTO(results: [sampleMovieDTO])
        mockClient.response = response

        let expectation = expectation(description: "fetchMovies should return data")

        service.fetchMovies(query: "test", page: 1).done { result in
            XCTAssertEqual(result.results.count, 1)
            XCTAssertEqual(result.results.first?.title, "Inception")
            expectation.fulfill()
        }.catch { _ in
            XCTFail("Expected success")
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchTopRated_invalidURL() {
        mockClient.error = NetworkError.invalidURL

        let expectation = expectation(description: "fetchTopRated should fail")

        service.fetchTopRated(page: 1).done { _ in
            XCTFail("Expected error")
        }.catch { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
