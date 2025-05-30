//
//  UISearchBar.swift
//  BrowseNow
//
//  Created by Dipika Bari on 08/05/2025.
//

import UIKit

extension UISearchBar {
    func setLeftImage(_ image: UIImage?) {
        guard let image = image else {
            searchTextField.leftView = nil
            return
        }
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.tintColor =  .systemPurple
        searchTextField.leftView = imageView
    }
}
