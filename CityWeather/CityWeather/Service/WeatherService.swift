//
//  WeatherService.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

typealias WeatherResponse = (CityWeatherData?, ResponseError?) -> Void

protocol WeatherServiceProvider {
    func fetchWeatherFor(city: String, completion: @escaping WeatherResponse)
}

struct WeatherService: WeatherServiceProvider, HTTPClient {
    func fetchWeatherFor(city: String, completion: @escaping WeatherResponse) {
        load(networkRequest: NetworkRequest<CityWeatherData>.currentWeather(city: city)) { result in
            switch result {
            case .success(let result):
                completion(result, nil)
            case .failure(let responseError):
                completion(nil, responseError)
            }
        }
    }
}
