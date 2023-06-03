//
//  NetworkRequest.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

// MARK: - NetworkRequest
struct NetworkRequest<T: Decodable> {
    // MARK: - Properties
    let url: String
    let parameters: [String: CustomStringConvertible]
    var request: URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map({ (key) -> URLQueryItem in
            URLQueryItem(name: key, value: parameters[key]?.description)
        })
        guard let url = components.url else {
            return nil
        }
        return URLRequest(url: url)
    }

    // MARK: - Custom Initializer
    init(url: String, parameters: [String: CustomStringConvertible] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}

// MARK: - NetworkRequest Helper
extension NetworkRequest {
    static func currentWeather(city: String) -> NetworkRequest<CityWeatherData> {
        let url = WeatherAPIConstants.baseURL + WeatherAPIConstants.weatherService
        let parameters: [String: CustomStringConvertible] = [
            WeatherAPIConstants.QueryParameters.appid: WeatherAPIConstants.apiId,
            WeatherAPIConstants.QueryParameters.city: city,
            WeatherAPIConstants.QueryParameters.units: WeatherAPIConstants.metric
        ]
        return NetworkRequest<CityWeatherData>(url: url, parameters: parameters)
    }

    static func forecastWeather(cityId: String) -> NetworkRequest<FutureForecasts> {
        let url = WeatherAPIConstants.baseURL + WeatherAPIConstants.forcastService
        let parameters: [String: CustomStringConvertible] = [
            WeatherAPIConstants.QueryParameters.appid: WeatherAPIConstants.apiId,
            WeatherAPIConstants.QueryParameters.cityId: cityId,
            WeatherAPIConstants.QueryParameters.units: WeatherAPIConstants.metric
        ]
        return NetworkRequest<FutureForecasts>(url: url, parameters: parameters)
    }
}
