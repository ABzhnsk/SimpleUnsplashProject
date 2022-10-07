//
//  UIImageView+.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import Kingfisher
import UIKit

extension UIImageView {
    func load(from url: String) {
        guard let url = URL(string: url) else { return }
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
