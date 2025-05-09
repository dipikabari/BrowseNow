//
//  APIConstants.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation

struct APIConstants {
    static let apiKey = "3215a185b25eb297a66e63d137fb994f"
    static let baseURLString = "https://api.themoviedb.org/3"
    static let posterImageBaseURLString = "https://image.tmdb.org/t/p/w500"
    static let backdropImageBaseURLString = "https://image.tmdb.org/t/p/w780"
}

enum MovieEndpoint {
    static func search(query: String, page: Int = 1) -> URLRequest? {
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "\(APIConstants.baseURLString)/search/movie?api_key=\(APIConstants.apiKey)&query=\(queryEncoded ?? "")&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            preconditionFailure("Invalid URL: \(urlString)")
        }
        
        return URLRequest(url: url)
    }
    
    static func topRated(page: Int = 1) -> URLRequest? {
        let urlString = "\(APIConstants.baseURLString)/movie/top_rated?api_key=\(APIConstants.apiKey)&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            preconditionFailure("Invalid URL: \(urlString)")
        }
        
        return URLRequest(url: url)
    }
}


