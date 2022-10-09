//
//  SearchViewController.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    public var presenter: SearchPresenter!
    
    private let searchView = SearchView()

    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        setupNavBar()
    }
}

// MARK: - Configure collection and setup navigation bar
extension SearchViewController {
    private func configureCollection() {
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    private func setupNavBar() {
        navigationItem.title = "Search"
        navigationItem.searchController = searchView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchView.searchController.searchBar.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getPictures().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        let photos = presenter.getPictures()[indexPath.item]
        let photoURL = URL(string: photos.imageUrl)
        cell.imageView.sd_setImage(with: photoURL, completed: nil)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: Constants.spacing)
        return CGSize(width: width, height: width)
    }
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoModel = presenter.getPictures()[indexPath.row]
        presenter.selectPhoto(photo: photoModel)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        presenter.fetchData(with: query)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.fetchData(with: "")
    }
}

// MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func success() {
        searchView.collectionView.reloadData()
    }
    func failure(error: APIError) {
        AlertBuilder()
            .title("Error")
            .message(error.errorDescription)
            .action("OK")
            .show(self, animated: true)
    }
}
