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
            return "Response parsing failed"
        case .invalidURL:
            return "Endpoint is not valid"
        case .noResponse:
            return "City weather data not found"
        case .unexpectedStatusCode, .unknown, .unauthorized:
            return "Unknown error\nPlease try again"
        }
    }
}
