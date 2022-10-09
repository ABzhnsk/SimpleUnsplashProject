//
//  NetworkDataFetch.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import Foundation
import SwiftyJSON

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchPhoto(api: API, response: @escaping (Result<[ResultsModel], APIError>) -> Void) {
        NetworkRequest.shared.requestData(api: api) { result in
            switch result {
            case .success(let data):
                do {
                    let json = JSON(data)
                    let photoJSON = json[].arrayValue.compactMap { ResultsModel($0) }
                    response(.success(photoJSON))
                } 
            case .failure(_):
                response(.failure(.invalidDataError))
            }
        }
    }
}
