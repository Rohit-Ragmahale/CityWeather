//
//  StoryboardIdentifier.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

// MARK: Enum for Storyboard name
enum Storyboard: String {
    case main = "Main"
}

// MARK: Enum for Storyboard Identifier
enum StoryboardIdentifier: String {
    case weatherSearch
    case weatherForecast

    var storyboardName: String {
        switch self {
        case .weatherSearch, .weatherForecast:
            return Storyboard.main.rawValue
        }
    }
}
