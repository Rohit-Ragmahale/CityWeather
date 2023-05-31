//
//  ForecastService.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

typealias WeatherForecatsResponse = ([DayForecast]?, ResponseError?) -> Void

protocol WeatherForecastServiceProvider {
    func fetchWeatherForecastFor(cityCode: String, completion: @escaping WeatherForecatsResponse)
}

struct WeatherForecastService: WeatherForecastServiceProvider {
    private let httpsClient: HTTPClientInterface

    init(httpsClient: HTTPClientInterface) {
        self.httpsClient = httpsClient
    }

    func fetchWeatherForecastFor(cityCode: String, completion: @escaping WeatherForecatsResponse) {
        httpsClient.load(networkRequest: NetworkRequest<FutureForecasts>.forecastWeather(cityCode: cityCode)) { result in
            switch result {
            case .success(let result):
                completion(result.list, nil)
            case .failure(let responseError):
                completion(nil, responseError)
            }
        }
    }
}
