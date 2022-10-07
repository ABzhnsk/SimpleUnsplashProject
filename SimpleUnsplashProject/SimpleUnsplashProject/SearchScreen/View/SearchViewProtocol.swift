//
//  SearchViewProtocol.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import Foundation

protocol SearchViewProtocol {
    func success()
    func failure(error: APIError)    
}
