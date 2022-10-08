//
//  UILabel+.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 09.10.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textAlignment = textAlignment
    }
}
