//
//  Formatter+.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import Foundation

extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = "."
        formatter.currencyGroupingSeparator = ","
        return formatter
    }()

    static let isoDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}
