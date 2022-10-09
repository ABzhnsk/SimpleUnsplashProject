//
//  FavouritePicturesViewController.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import UIKit

class FavouritePicturesViewController: UIViewController {
    public var presenter: FavouritePicturesPresenter!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let emptyTextLabel: UILabel = {
        let label = UILabel(text: "No photos",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .center)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupUI()
        presenter.fetchFavouritePictures()
        setupNotificationCenter()
    }
}

extension FavouritePicturesViewController {
    private func setupUI() {
        setupTableView()
        setupNavBar()
        setupEmptyTextLabel()
    }
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(emptyTextLabel)
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    private func setupEmptyTextLabel() {
        emptyTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1),
            emptyTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1)
        ])
    }
    private func setupNavBar() {
        navigationItem.title = "Favorite"
    }
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: Notification.Name.heartButtonClicked, object: nil)
    }
    
    @objc private func fetch() {
        presenter.fetchFavouritePictures()
    }
}

extension FavouritePicturesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPhotos().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else { return UITableViewCell() }
        let photo = presenter.getPhotos()[indexPath.row]
        cell.configure(from: photo)
        return cell
    }
}

extension FavouritePicturesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FavouritePicturesViewController: FavouritePicturesViewProtocol {
    func errorCoreData(with message: String) {
        AlertBuilder()
            .title("Error")
            .message(message)
            .action("OK")
            .show(self, animated: true)
    }
    func success() {
        DispatchQueue.main.async { [weak self] in
            self?.emptyTextLabel.isHidden = self?.presenter.getPhotos().isEmpty == true ? false : true
        }
        tableView.reloadData()
    }
}
