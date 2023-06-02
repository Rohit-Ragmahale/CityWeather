//
//  MockHTTPClient.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import Foundation

private enum MockFile: String {
    case weatherResponse = "CityWeatherDataResponse"
    case forecastResponse = "ForecastResponse"
}

struct MockHTTPClient: HTTPClientInterface {
    func load<T: Decodable>(networkRequest: NetworkRequest<T>,
                            completion: @escaping (Result<T, ResponseError>) -> Void) {
        var data: Data?
        if networkRequest.url.contains(WeatherAPIConstants.weatherService) {
            data = try? TestUtils.data(forResource: MockFile.weatherResponse.rawValue)
        } else if networkRequest.url.contains(WeatherAPIConstants.forcastService) {
            data = try? TestUtils.data(forResource: MockFile.forecastResponse.rawValue)
        }
        guard let data = data else {
            completion( .failure(.unexpectedStatusCode))
            return
        }
        guard let cityWeatherData = try? JSONDecoder().decode(T.self, from: data) else {
            completion( .failure(.unexpectedStatusCode))
            return
        }
        completion( .success(cityWeatherData))
    }
}
