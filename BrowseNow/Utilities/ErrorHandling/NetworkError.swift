//
//  NetworkError.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation

enum NetworkError: Error, Equatable {
    case network(Error)
    case invalidResponse
    case noData
    case decoding(Error)
    case invalidURL
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.network, .network):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.noData, .noData):
            return true
        case (.decoding, .decoding):
            return true
        case (.invalidURL, .invalidURL):
            return true
        default:
            return false
        }
    }
}
