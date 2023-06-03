//
//  WeatherService.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

typealias WeatherResponse = (CityWeatherData?, ResponseError?) -> Void

// MARK: - WeatherService Interface
protocol WeatherServiceProvider {
    func fetchWeatherFor(city: String, completion: @escaping WeatherResponse)
}

struct WeatherService {
    // MARK: - Properties
    private let httpsClient: HTTPClientInterface

    // MARK: - Custom Initializer
    init(httpsClient: HTTPClientInterface) {
        self.httpsClient = httpsClient
    }
}

// MARK: - WeatherService Interface Implementation
extension WeatherService: WeatherServiceProvider {
    func fetchWeatherFor(city: String, completion: @escaping WeatherResponse) {
        let request = NetworkRequest<CityWeatherData>.currentWeather(city: city)
        httpsClient.load(networkRequest: request) { result in
            switch result {
            case .success(let result):
                completion(result, nil)

            case .failure(let responseError):
                completion(nil, responseError)
            }
        }
    }
}
