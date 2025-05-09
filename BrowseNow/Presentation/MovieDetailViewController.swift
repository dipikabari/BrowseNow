//
//  MovieDetailViewController.swift
//  BrowseNow
//
//  Created by Dipika Bari on 09/05/2025.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let viewModel: MovieDetailViewModel
        
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let backdropImageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private let languageLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let overviewLabel = UILabel()
    
    private lazy var contentStackView = UIStackView(arrangedSubviews: [backdropImageView, titleLabel, ratingLabel, languageLabel, releaseDateLabel, overviewLabel])
    
    // MARK: - Init
    init(movie: Movie) {
        self.viewModel = MovieDetailViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        populateData()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        ratingLabel.font = .systemFont(ofSize: 16)
        
        languageLabel.font = .systemFont(ofSize: 14)
       
        releaseDateLabel.font = .systemFont(ofSize: 14)
        
        overviewLabel.font = .systemFont(ofSize: 18)
        overviewLabel.numberOfLines = 0
        overviewLabel.lineBreakMode = .byWordWrapping
        overviewLabel.textColor = .systemPurple
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 24
        contentStackView.setCustomSpacing(8, after: titleLabel)
        
        // Add scrollable content
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        applyConstraints()
    }
    
    // MARK: - Configure with Movie
    private func populateData() {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = "Release Date: \(viewModel.formattedReleaseDate)"
        languageLabel.text = "Language: \(viewModel.languageDisplay)"
        ratingLabel.text = "Rating: \(viewModel.formattedRating)/10"
        overviewLabel.text = viewModel.overview
          
        if let url = viewModel.backdropURL {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                self?.backdropImageView.image = image
            }
        }
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data else { return }
            DispatchQueue.main.async {
                self.backdropImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

       NSLayoutConstraint.activate([
           scrollView.topAnchor.constraint(equalTo: view.topAnchor),
           scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

           backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
           backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 11 / 16, constant: 0),

           contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
           contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
           contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
           contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24)
       ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
