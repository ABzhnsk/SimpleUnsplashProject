//
//  ReusableViewProtocol.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import Foundation

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}
