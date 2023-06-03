//
//  ResponseError.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

// MARK: - API Response Errors
enum ResponseError: Error {
    case decode
    case invalidURL
    case unexpectedStatusCode

    // MARK: - Localized Error Description
    var errorDescription: String {
        switch self {
        case .decode:
            return WeatherApp.errorRemoteDataParsingFailed.localized
        case .invalidURL:
            return WeatherApp.errorInvalidEndPoint.localized
        case .unexpectedStatusCode:
            return WeatherApp.errorUnknown.localized
        }
    }
}
