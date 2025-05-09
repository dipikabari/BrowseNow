//
//  MovieSearchViewController.swift
//  BrowseNow
//
//  Created by Dipika Bari on 07/05/2025.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    // MARK: UI
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Strings.noResultLabelText
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.UI.labelSize, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    // MARK: Properties
    private var movies: [Movie] = []
    private var viewModel: MovieSearchViewModelProtocol
    
    // MARK: Init
    init(viewModel: MovieSearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupAccessibility()
        viewModel.loadInitialMovies()
    }

    // MARK: Setup
    
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = Constants.Strings.topMoviesTitle
 
        configureSearchBar()
        view.addSubview(searchBar)
        
        configureTableView()
        view.addSubview(tableView)
        
        view.addSubview(noResultsLabel)
        applyConstraints()
    }
    
    private func setupBindings() {
        viewModel.onMoviesFetched = { [weak self] newMovies in
            guard let self else { return }
            DispatchQueue.main.async {
                self.noResultsLabel.isHidden = !newMovies.isEmpty
                self.tableView.isHidden = newMovies.isEmpty
                
                if self.viewModel.currentPage == Constants.UI.currentPage {
                    self.movies = newMovies
                } else {
                    self.movies.append(contentsOf: newMovies)
                }
                self.tableView.reloadData()
            }
        }
        
        viewModel.onSearchError = { [weak self] error in
            DispatchQueue.main.async {
                self?.noResultsLabel.isHidden = false
                self?.tableView.isHidden = true
            }
        }
  
      }
    
    private func applyConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UISearchBarDelegate
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        Logger.log("\(Constants.Strings.placeholderText): \(query)", level: .info)
        viewModel.search(query: query)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        viewModel.loadInitialMovies()
        searchBar.resignFirstResponder()
    }
}

// MARK: UITableViewDataSource
extension MovieSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movie)
        return cell
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            viewModel.loadMore()
        }
    }
}

extension MovieSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        let detailVC = MovieDetailViewController(movie: selectedMovie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MovieSearchViewController {
     func configureSearchBar() {
         searchBar.placeholder = Constants.Strings.placeholderText
         searchBar.setLeftImage(UIImage(systemName: Constants.Strings.magnifyingGlassIconName))
         searchBar.layer.cornerRadius = Constants.UI.cornerRadius
         searchBar.searchTextField.adjustsFontForContentSizeCategory = true
         searchBar.delegate = self
     }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.UI.rowHeight
    }
    
   func setupAccessibility() {
       searchBar.accessibilityLabel = Constants.Strings.searchBarAccessibilityLabel
       searchBar.accessibilityHint = Constants.Strings.searchBarAccessibilityHint
       
       tableView.accessibilityLabel = Constants.Strings.tableViewAccessibilityLabel
        
       noResultsLabel.isAccessibilityElement = true
       noResultsLabel.accessibilityLabel = Constants.Strings.noResultLabelText
       noResultsLabel.accessibilityTraits = .staticText
    }
}

extension MovieSearchViewController {
    private enum Constants {
        enum Strings {
            static let topMoviesTitle = "Top Movies"
            static let placeholderText = "Search movie..."
            static let magnifyingGlassIconName = "magnifyingglass"
            static let noResultLabelText = "Something went wrong.\nPlease try again."
            static let searchBarAccessibilityLabel = "Search for movies"
            static let searchBarAccessibilityHint = "Enter a movie title to search"
            static let tableViewAccessibilityLabel = "List of movies"
        }
        
        enum UI {
            static let cornerRadius: CGFloat = 8
            static let rowHeight: CGFloat = 140
            static let currentPage: Int = 1
            static let labelSize: CGFloat = 16
            static let titleFontSize: CGFloat = 22
        }
        
    }
}
