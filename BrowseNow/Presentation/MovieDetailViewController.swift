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
    
    private lazy var contentStackView = UIStackView(arrangedSubviews: [
        backdropImageView, titleLabel, ratingLabel, languageLabel, releaseDateLabel, overviewLabel
    ])
    
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
        
        titleLabel.font = .boldSystemFont(ofSize: Constants.UI.titleFontSize)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        ratingLabel.font = .systemFont(ofSize: Constants.UI.subtitleFontSize)
        
        languageLabel.font = .systemFont(ofSize: Constants.UI.subtitleFontSize)
       
        releaseDateLabel.font = .systemFont(ofSize: Constants.UI.subtitleFontSize)
        
        overviewLabel.font = .systemFont(ofSize: Constants.UI.overviewFontSize)
        overviewLabel.numberOfLines = 0
        overviewLabel.lineBreakMode = .byWordWrapping
        overviewLabel.textColor = .systemPurple
        
        contentStackView.axis = .vertical
        contentStackView.spacing = Constants.UI.stackViewSpacing
        contentStackView.setCustomSpacing(Constants.UI.customSpacing, after: titleLabel)
        
        // Add scrollable content
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        applyConstraints()
    }
    
    // MARK: - Configure with Movie
    private func populateData() {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = Constants.Strings.releaseDate(viewModel.formattedReleaseDate)
        languageLabel.text = Constants.Strings.language(viewModel.languageDisplay)
        ratingLabel.text = Constants.Strings.ratingLabel(viewModel.formattedRating)
        overviewLabel.text = viewModel.overview
          
        if let url = viewModel.backdropURL {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                self?.backdropImageView.image = image
            }
        }
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

           backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.UI.defaultSpacing),
           backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.UI.defaultSpacing),
           backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: Constants.UI.imageMultiplier, constant: 0),

           contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.UI.stackViewSpacing),
           contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.UI.defaultSpacing),
           contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.UI.defaultSpacing),
           contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.UI.stackViewSpacing)
       ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MovieDetailViewController {
    private enum Constants {
        enum Strings {
            static func releaseDate(_ formattedReleaseDate: String) -> String {
                "Release Date: \(formattedReleaseDate)"
            }
            
            static func language(_ languageDisplay: String) -> String {
                "Language: \(languageDisplay)"
            }
            
            static func ratingLabel(_ rating: String) -> String {
                "Rating: \(rating)/10"
            }
        }
        
        enum UI {
            static let defaultSpacing: CGFloat = 16
            static let stackViewSpacing: CGFloat = 24
            static let customSpacing: CGFloat = 8
            static let imageMultiplier: CGFloat = 11 / 16
            static let titleFontSize: CGFloat = 22
            static let subtitleFontSize: CGFloat = 14
            static let overviewFontSize: CGFloat = 18
        }
        
    }
}
