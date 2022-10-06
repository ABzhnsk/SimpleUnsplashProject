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
    private let likeButton: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        let nonLikeImage = UIImage(systemName: "suit.heart") as UIImage?
        button.frame = CGRect(x: 1, y: 1, width: 40, height: 40)
        button.tintColor = .red
        button.setImage(nonLikeImage, for: .normal)
        return button
    }()
    
    var buttonTapCallback: () -> ()  = { }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .black
        contentView.addSubview(likeButton)
        contentView.addSubview(imageView)
    }
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        let xContraints = NSLayoutConstraint(item: likeButton, attribute: NSLayoutConstraint.Attribute.bottomMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.bottomMargin, multiplier: 1, constant: -5)
        let yContraints = NSLayoutConstraint(item: likeButton, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10)
        NSLayoutConstraint.activate([xContraints,yContraints])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(image: UIImage?) {
        self.imageView.image = image
    }
    
    @objc private func didTapLikeButton() {
        buttonTapCallback()
    }
}

extension SearchCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
