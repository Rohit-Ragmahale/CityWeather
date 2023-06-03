//
//  MockHTTPClient.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import Foundation
import Combine

// MARK: - MockFiles
private enum MockFile: String {
    case weatherResponse = "CityWeatherDataResponse"
    case forecastResponse = "ForecastResponse"
}

// MARK: - Mock HTTPClient Implementation
struct MockHTTPClient: HTTPClientInterface {
    func load<T: Decodable>(networkRequest: NetworkRequest<T>) -> AnyPublisher<T, ResponseError> {
        var data: Data?
        if networkRequest.url.contains(WeatherAPIConstants.weatherService) {
            data = try? TestUtils.data(forResource: MockFile.weatherResponse.rawValue)
        } else if networkRequest.url.contains(WeatherAPIConstants.forcastService) {
            data = try? TestUtils.data(forResource: MockFile.forecastResponse.rawValue)
        }

        guard let data = data else {
            return Fail(error: ResponseError.unexpectedStatusCode).eraseToAnyPublisher()
        }
        guard let cityWeatherData: T = try? JSONDecoder().decode(T.self, from: data) else {
            return Fail(error: ResponseError.decode).eraseToAnyPublisher()
        }
        return Just(cityWeatherData)
            .setFailureType(to: ResponseError.self)
            .eraseToAnyPublisher()
    }
}
