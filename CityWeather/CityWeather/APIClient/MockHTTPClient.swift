//
//  MockHTTPClient.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import Foundation

struct MockHTTPClient: HTTPClientInterface {
    func load<T: Decodable>(networkRequest: NetworkRequest<T>,
                            completion: @escaping (Result<T, ResponseError>) -> Void) {
        var data: Data?
        if networkRequest.url.contains(WeatherAPIConstants.weatherService) {
            data = try? TestUtils.data(forResource: "CityWeatherDataResponse")
        } else if networkRequest.url.contains(WeatherAPIConstants.forcastService) {
            data = try? TestUtils.data(forResource: "ForecastResponse")
        }
        if let data = data {
            if let cityWeatherData = try? JSONDecoder().decode(T.self, from: data) {
                completion( .success(cityWeatherData))
            } else {
                completion( .failure(.unexpectedStatusCode))
            }
        } else {
            completion( .failure(.unexpectedStatusCode))
        }
    }
}
