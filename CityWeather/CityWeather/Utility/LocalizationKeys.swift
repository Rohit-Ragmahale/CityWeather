//
//  LocalizationKeys.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import Foundation

protocol Localized {
    var localized: String { get }
}

enum WeatherApp: String, Localized {
    case searchWeather_title
    case searchWeather_searchTitle
    case searchWeather_enter_city

    case temperature_details
    case humidity_details
    
    case error
    case ok
    
    case temp_data_not_avaialble
    case humidity_data_not_avaialble
    
    var localized: String {
        self.rawValue.localized
    }
}


