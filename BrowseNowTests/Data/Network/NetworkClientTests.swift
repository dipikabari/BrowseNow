//
//  NetworkClientTests.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 10/05/2025.
//

import XCTest
import PromiseKit
@testable import BrowseNow

final class NetworkClientTests: XCTestCase {
    func test_request_decodesMockData() {
        struct MockModel: Codable, Equatable {
            let title: String
        }

        let json = """
        {
            "title": "MovieA"
        }
        """

        let session = MockURLSession(json: json)
        let client = NetworkClient(session: session)
        let request = URLRequest(url: URL(string: "https://mock.test")!)

        let expectation = expectation(description: "Request completes")

        firstly {
            client.request(endPoint: request) as Promise<MockModel>
        }.done { result in
            XCTAssertEqual(result.title, "MovieA")
            expectation.fulfill()
        }.catch { error in
            XCTFail("Unexpected error: \(error)")
        }

        waitForExpectations(timeout: 1)
    }
}
