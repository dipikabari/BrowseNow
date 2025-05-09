//
//  MovieTableViewCell.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MovieTableViewCell"
    
    private let movieImageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private let horizontalStack = UIStackView()
    private let textStackView = UIStackView()
    private var imageLoader: ImageLoaderProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        ratingLabel.textColor = .systemPurple

        textStackView.axis = .vertical
        textStackView.spacing = 4
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(ratingLabel)

        horizontalStack.addArrangedSubview(movieImageView)
        horizontalStack.addArrangedSubview(textStackView)
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 12
        horizontalStack.alignment = .top
       

        contentView.addSubview(horizontalStack)
       
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            movieImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title

        let movieRating = String(format: "Rating: %.1f/10", movie.voteAverage)
        ratingLabel.text = movieRating
        
        if let urlString = movie.fullPosterURL,
           let url = URL(string: urlString) {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                self?.movieImageView.image = image
                self?.setNeedsLayout()
            }
        } else {
            movieImageView.image = UIImage(systemName: "xmark.octagon")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
