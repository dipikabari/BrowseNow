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
    private let overview = UILabel()
    private let ratingLabel = UILabel()
    private let horizontalStack = UIStackView()
    private let textStackView = UIStackView()
    
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
        
        overview.font = UIFont.systemFont(ofSize: 14)
        overview.textColor = .darkGray
        overview.numberOfLines = 0
        overview.lineBreakMode = .byWordWrapping

        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        ratingLabel.textColor = .systemOrange

        textStackView.axis = .vertical
        textStackView.spacing = 4
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(overview)
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
        overview.text = "\(movie.overview)"
        let rating = Int(movie.voteAverage)
        ratingLabel.text = "Rating: \(rating)/10"
        
        if let urlString = movie.fullPosterURL {
            loadImage(from: urlString)
        } else {
            movieImageView.image = UIImage(systemName: "xmark.octagon")
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            movieImageView.image = UIImage(systemName: "xmark.octagon")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
