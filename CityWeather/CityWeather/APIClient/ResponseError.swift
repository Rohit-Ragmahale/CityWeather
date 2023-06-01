//
//  ResponseError.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

enum ResponseError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown

    var errorDescription: String {
        switch self {
        case .decode:
            return WeatherApp.errorRemoteDataParsingFailed.localized
        case .invalidURL:
            return WeatherApp.errorInvalidEndPoint.localized
        case .noResponse:
            return WeatherApp.errorWeatherDataNotFound.localized
        case .unexpectedStatusCode, .unknown, .unauthorized:
            return WeatherApp.errorUnknown.localized
        }
    }
}
