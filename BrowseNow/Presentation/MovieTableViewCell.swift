//
//  MovieTableViewCell.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    static let reuseIdentifier = Constants.Strings.reuseIdentifier
    
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
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.UI.titleFontSize)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        ratingLabel.font = UIFont.systemFont(ofSize: Constants.UI.ratingFontSize)
        ratingLabel.textColor = .systemPurple

        textStackView.axis = .vertical
        textStackView.spacing = Constants.UI.textStackViewSpacing
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(ratingLabel)

        horizontalStack.addArrangedSubview(movieImageView)
        horizontalStack.addArrangedSubview(textStackView)
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = Constants.UI.defaultSpacing
        horizontalStack.alignment = .top
       

        contentView.addSubview(horizontalStack)
       
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.UI.stackSpacing),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.UI.defaultSpacing),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.UI.defaultSpacing),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.stackSpacing),
            
            movieImageView.widthAnchor.constraint(equalToConstant: Constants.UI.imageWidth),
            movieImageView.heightAnchor.constraint(equalToConstant: Constants.UI.imageHeight)
        ])
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title

        let movieRating = String(format: Constants.Strings.ratingFormat, movie.voteAverage)
        ratingLabel.text = movieRating
        
        accessibilityLabel = Constants.Strings.accessibilityLabel(movie.title, movieRating)
        accessibilityHint = Constants.Strings.accessibilityHint
        
        if let urlString = movie.fullPosterURL,
           let url = URL(string: urlString) {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                self?.movieImageView.image = image
                self?.setNeedsLayout()
            }
        } else {
            movieImageView.image = UIImage(systemName: Constants.Strings.placeholderImageName)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieTableViewCell {
    enum Constants {
        enum Strings {
            static let reuseIdentifier = "MovieTableViewCell"
            static let ratingFormat = "Rating: %.1f/10"
            static let placeholderImageName = "xmark.octagon"
            static func accessibilityLabel(_ movieTitle: String, _ movieRating: String) -> String {
                let spokenRating = movieRating.replacingOccurrences(of: "/", with: " out of ")
                return "\(movieTitle), \(spokenRating)"
            }
            static let accessibilityHint = "Tap to view movie details"
        }
        
        enum UI {
            static let defaultSpacing: CGFloat = 12
            static let stackSpacing: CGFloat = 8
            static let stackViewSpacing: CGFloat = 24
            static let textStackViewSpacing: CGFloat = 4
            static let titleFontSize: CGFloat = 16
            static let ratingFontSize: CGFloat = 14
            static let imageWidth: CGFloat = 80
            static let imageHeight: CGFloat = 120
        }
        
    }
}
