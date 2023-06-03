//
//  StringExtension.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import Foundation

extension String {
    // MARK: - Localized String
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
