//
//  MockGetMoviesUseCase.swift
//  BrowseNowTests
//
//  Created by Dipika Bari on 10/05/2025.
//

import Foundation
import PromiseKit
@testable import BrowseNow

final class MockGetMoviesUseCase: GetMoviesUseCase {
    var executeHandler: ((String, Int) -> Promise<[Movie]>)?
    var fetchTopRatedHandler: ((Int) -> Promise<[Movie]>)?
    
    func execute(query: String, page: Int) -> PromiseKit.Promise<[BrowseNow.Movie]> {
        if let handler = executeHandler {
            return handler(query, page)
        } else {
            return Promise.value([])
        }
    }
    
    func fetchTopRated(page: Int) -> PromiseKit.Promise<[BrowseNow.Movie]> {
        if let handler = fetchTopRatedHandler {
            return handler(page)
        } else {
            return Promise.value([])
        }
    }
}
