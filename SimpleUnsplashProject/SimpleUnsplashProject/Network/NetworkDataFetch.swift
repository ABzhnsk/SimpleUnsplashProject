//
//  NetworkDataFetch.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchPhoto(api: API, response: @escaping (Result<PhotoModel, APIError>) -> Void) {
        NetworkRequest.shared.requestData(api: api) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(PhotoModel.self, from: data)
                    response(.success(jsonData))
                } catch {
                    response(.failure(.decodeError))
                }
            case .failure(_):
                response(.failure(.invalidDataError))
            }
        }
    }
}
