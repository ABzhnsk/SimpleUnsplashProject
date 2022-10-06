//
//  SearchCollectionViewCell.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    private enum Constants {
        static let contentViewCornerRadius: CGFloat = 4.0
    }
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .black
        contentView.addSubview(imageView)
    }
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(image: UIImage?) {
        self.imageView.image = image
    }
}

extension SearchCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
