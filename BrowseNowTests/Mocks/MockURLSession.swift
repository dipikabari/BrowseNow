//
//  MockURLSession.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 11/05/2025.
//

import Foundation
@testable import BrowseNow

class MockURLSession: URLSessionProtocol, @unchecked Sendable {
    let mockData: Data
    let statusCode: Int

    init(json: String, statusCode: Int = 200) {
        self.mockData = json.data(using: .utf8)!
        self.statusCode = statusCode
    }
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
        return MockTask {
            completionHandler(self.mockData, response, nil)
        }
    }

    class MockTask: URLSessionDataTask, @unchecked Sendable {
        private let handler: () -> Void
        init(handler: @escaping () -> Void) {
            self.handler = handler
        }
        override func resume() {  handler() }
    }
}

