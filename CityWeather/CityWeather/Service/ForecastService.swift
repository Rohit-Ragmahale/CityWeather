//
//  ForecastService.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation
import Combine

typealias WeatherForecatsResponse = ([DayForecast]?, ResponseError?) -> Void

// MARK: - WeatherForecastService Interface
protocol WeatherForecastServiceProvider {
    //func fetchWeatherForecastFor(cityId: String, completion: @escaping WeatherForecatsResponse)
    func fetchWeatherForecastFor(cityId: String) async throws -> [DayForecast]
}

final class WeatherForecastService {
    // MARK: - Properties
    private let httpsClient: HTTPClientInterface
    private var cancellables: [AnyCancellable] = []

    // MARK: - Custom Initializer
    init(httpsClient: HTTPClientInterface) {
        self.httpsClient = httpsClient
    }
}

extension WeatherForecastService: WeatherForecastServiceProvider {
    func fetchWeatherForecastFor(cityId: String) async throws -> [DayForecast] {
        return try await withCheckedThrowingContinuation({ continuation in
            let request = NetworkRequest<FutureForecasts>.forecastWeather(cityId: cityId)
            httpsClient.load(networkRequest: request).sink { reqCompletion in
                if case let .failure(error) = reqCompletion {
                    continuation.resume(throwing: error)
                }
            } receiveValue: { data in
                continuation.resume(returning: data.list)
            }
            .store(in: &cancellables)
        })
    }
    
    /*
    func fetchWeatherForecastFor(cityId: String, completion: @escaping WeatherForecatsResponse) {
        let request = NetworkRequest<FutureForecasts>.forecastWeather(cityId: cityId)
        httpsClient.load(networkRequest: request).sink { reqCompletion in
            if case let .failure(error) = reqCompletion {
                completion(nil, error)
            }
        } receiveValue: { data in
            completion(data.list, nil)
        }
        .store(in: &cancellables)
    }
     */
}
