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
    case searchWeatherTitle
    case searchWeatherSearchTitle
    case searchWeatherEnterCity

    case temperatureDetails
    case humidityDetails

    case error
    case okTitle

    case tempDataNotAvaialble
    case humidityDataNotAvaialble

    case errorRemoteDataParsingFailed
    case errorInvalidEndPoint
    case errorWeatherDataNotFound
    case errorUnknown

    var localized: String {
        self.rawValue.localized
    }
}
