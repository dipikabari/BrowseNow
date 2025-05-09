//
//  ImageLoader.swift
//  BrowseNow
//
//  Created by Dipika Bari on 09/05/2025.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

final class ImageLoader: ImageLoaderProtocol {
    static let shared = ImageLoader()
    
    private let cache = NSCache<NSURL, UIImage>()
    private let session: URLSession
    
    private init(session: URLSession = .shared){
        self.session = session
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cached = cache.object(forKey: url as NSURL) {
            completion(cached)
            return
        }
        
        session.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
