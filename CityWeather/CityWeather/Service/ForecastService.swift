//
//  ForecastService.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

typealias WeatherForecatsResponse = ([DayForecast]?, ResponseError?) -> Void

// MARK: - WeatherForecastService Interface
protocol WeatherForecastServiceProvider {
    func fetchWeatherForecastFor(cityId: String, completion: @escaping WeatherForecatsResponse)
}

struct WeatherForecastService {
    // MARK: - Properties
    private let httpsClient: HTTPClientInterface

    // MARK: - Custom Initializer
    init(httpsClient: HTTPClientInterface) {
        self.httpsClient = httpsClient
    }
}

extension WeatherForecastService: WeatherForecastServiceProvider {
    func fetchWeatherForecastFor(cityId: String, completion: @escaping WeatherForecatsResponse) {
        let request = NetworkRequest<FutureForecasts>.forecastWeather(cityId: cityId)
        httpsClient.load(networkRequest: request) { result in
            switch result {
            case .success(let result):
                completion(result.list, nil)

            case .failure(let responseError):
                completion(nil, responseError)
            }
        }
    }
}
