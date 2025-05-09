//
//  MovieDetailViewController.swift
//  BrowseNow
//
//  Created by Dipika Bari on 09/05/2025.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    //private let movie: Movie
    private let viewModel: MovieDetailViewModel
        
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private let languageLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let overviewLabel = UILabel()
    
    // MARK: - Init
    init(movie: Movie) {
        //self.movie = movie
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        
        ratingLabel.font = .systemFont(ofSize: 16)
        
        languageLabel.font = .systemFont(ofSize: 14)
       
        releaseDateLabel.font = .systemFont(ofSize: 14)
        
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.numberOfLines = 0
        
        // Add scrollable content
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [imageView, titleLabel, ratingLabel, languageLabel, releaseDateLabel, overviewLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
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
            loadImage(from: url)
        }
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
           contentView.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
               scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

               contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
               contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
               contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
               contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
               contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

               imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
               imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
               imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
               imageView.heightAnchor.constraint(equalToConstant: 220),

               titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
               titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

               ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
               ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

               languageLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 4),
               languageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
               
               releaseDateLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 4),
               releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

               overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 12),
               overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
               overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
               overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
           ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
