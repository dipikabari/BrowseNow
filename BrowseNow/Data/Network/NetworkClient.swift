//
//  NetworkClient.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import Foundation
import PromiseKit

protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @Sendable @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol NetworkClientProtocol {
    func request<T: Decodable>(endPoint: URLRequest) -> Promise<T>
}

final class NetworkClient: NetworkClientProtocol {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endPoint: URLRequest) -> Promise<T> {
        Logger.log("endPoint: \(endPoint)", level: .info)
        
        return Promise<T> { seal in
            session.dataTask(with: endPoint) { data, response, error in
                if let error = error {
                    Logger.log("Network error: \(error.localizedDescription)", level: .error)
                    seal.reject(NetworkError.network(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    Logger.log("Response: \(String(describing: response))", level: .error)
                    seal.reject(NetworkError.invalidResponse)
                    return
                }
                
                guard let data = data else {
                    seal.reject(NetworkError.noData)
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    seal.fulfill(decodedData)
                } catch {
                    Logger.log("Error fetching movies: \(error.localizedDescription)", level: .error)
                    seal.reject(NetworkError.decoding(error))
                }
            }.resume()
        }
    }
}
