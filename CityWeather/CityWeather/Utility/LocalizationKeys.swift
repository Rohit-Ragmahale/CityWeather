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

// MARK: - Application Localization Keys
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

    case tapToViewForecast

    // localized string
    var localized: String {
        rawValue.localized
    }
}
