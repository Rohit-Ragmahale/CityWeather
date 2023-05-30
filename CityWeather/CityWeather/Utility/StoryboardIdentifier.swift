//
//  StoryboardIdentifier.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

enum Storyboard: String {
    case Main
}

enum StoryboardIdentifier:  String {
    case weatherSearch

    var storyboardName: String {
        switch self {
        case .weatherSearch:
            return Storyboard.Main.rawValue
        }
    }
}
