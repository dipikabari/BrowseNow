//
//  NetworkError.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation

enum NetworkError: Error {
    case network(Error)
    case invalidResponse
    case noData
    case decoding(Error)
    case invalidURL
}
