//
//  FavouriteTableViewCell.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 09.10.2022.
//

import UIKit
import SDWebImage

class FavouriteTableViewCell: UITableViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    private let authorNameLabel: UILabel = {
        let label = UILabel(text: "Name",
                            font: .systemFont(ofSize: 15),
                            textAlignment: .left)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(authorNameLabel)
    }
    private func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 1),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImageView.heightAnchor.constraint(equalToConstant: 60),
            photoImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            authorNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 1),
            authorNameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 10)
        ])
    }
    
    func configure(from model: PhotoModel) {
        let imageURL = model.imageUrl
        photoImageView.sd_setImage(with: URL(string: imageURL))
        authorNameLabel.text = model.userName
    }
}

extension FavouriteTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
