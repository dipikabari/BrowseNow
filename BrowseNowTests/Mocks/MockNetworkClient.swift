//
//  MockNetworkClient.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 11/05/2025.
//

import Foundation
@testable import BrowseNow
import PromiseKit

class MockNetworkClient: NetworkClientProtocol {
    var response: Decodable?
    var error: Error?

    func request<T>(endPoint: URLRequest) -> Promise<T> where T : Decodable {
        if let error = error {
            return Promise<T>(error: error)
        }
        guard let castedResponse = response as? T else {
            return Promise<T>(error: NetworkError.noData)
        }
        return Promise.value(castedResponse)
    }
}
