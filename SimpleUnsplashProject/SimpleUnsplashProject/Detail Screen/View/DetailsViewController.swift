//
//  DetailsViewController.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()
    private var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
        button.clipsToBounds = true
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Title"
        return label
    }()
    private var authorNameLabel: UILabel = {
        let label = UILabel(text: "Author: none",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var dateCreateLabel: UILabel = {
        let label = UILabel(text: "Date create: none",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var locationLabel: UILabel = {
        let label = UILabel(text: "Location: none",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var downloadsLabel: UILabel = {
        let label = UILabel(text: "Downloads: none",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var presenter: DetailsViewPresenter!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchStateButton()
    }
}

// MARK: - UI settings
extension DetailsViewController {
    private func setupUI() {
        setupLabel()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(likeButton)
        view.addSubview(stackView)
        setupLikeButton()
        setupImageView()
        setupNavBar()
        setupStackView()
    }
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300)
        ])
    }
    private func setupLikeButton() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            likeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            likeButton.widthAnchor.constraint(equalToConstant: 60),
            likeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func setupStackView() {
        stackView.addArrangedSubview(authorNameLabel)
        stackView.addArrangedSubview(dateCreateLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(downloadsLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    private func setupNavBar() {
        navigationItem.title = titleLabel.text
    }
    private func setupLabel() {
        let isoDate = DateFormatter.isoDate.date(from: presenter.model.createdAt)
        let date = DateFormatter.date.string(from: isoDate ?? Date())
        let photoURL = URL(string: presenter.model.imageUrl)
        titleLabel.text = presenter.model.userName
        authorNameLabel.text = "Author: \(presenter.model.userName)"
        locationLabel.text = "Location: \(presenter.model.userLocation)"
        dateCreateLabel.text = "Created at: \(date)"
        downloadsLabel.text = "Downloads: \(presenter.model.downloads)"
        imageView.sd_setImage(with: photoURL)
    }
    private func fetchStateButton() {
        DispatchQueue.main.async { [weak self] in
            guard let isHeartSelected = self?.presenter.isHeartSelected else {
                return
            }
            self?.likeButton.tintColor = isHeartSelected ? .red : .white
        }
        presenter.fetchButtonIsLike()
    }
}

// MARK: - Actions
extension DetailsViewController {
    @objc private func likeButtonTapped() {
        fetchStateButton()
        presenter.fetchLikePhoto()
    }
}

// MARK: - DetailsViewProtocol
extension DetailsViewController: DetailsViewProtocol {
    func errorCoreData(with message: String) {
        AlertBuilder()
            .title("Error")
            .message(message)
            .action("OK")
            .show(self, animated: true)
    }
}
