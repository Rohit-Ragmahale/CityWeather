//
//  WeatherService.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation
import Combine

typealias WeatherResponse = (CityWeatherData?, ResponseError?) -> Void

// MARK: - WeatherService Interface
protocol WeatherServiceProvider {
    // func fetchWeatherFor(city: String, completion: @escaping WeatherResponse)
    func fetchWeatherFor(city: String) async throws -> CityWeatherData?
}

final class WeatherService {
    // MARK: - Properties
    private let httpsClient: HTTPClientInterface
    private var cancellables: [AnyCancellable] = []

    // MARK: - Custom Initializer
    init(httpsClient: HTTPClientInterface) {
        self.httpsClient = httpsClient
    }
}

// MARK: - WeatherService Interface Implementation
extension WeatherService: WeatherServiceProvider {
    func fetchWeatherFor(city: String) async throws -> CityWeatherData? {
        let request = NetworkRequest<CityWeatherData>.currentWeather(city: city)
        return try await withCheckedThrowingContinuation({ continuation in
            httpsClient.load(networkRequest: request).sink { reqCompletion in
                if case let .failure(error) = reqCompletion {
                    continuation.resume(throwing: error)
                }
            } receiveValue: { data in
                continuation.resume(returning: data)
            }
            .store(in: &cancellables)
        })
    }
    /*
    func fetchWeatherFor(city: String, completion: @escaping WeatherResponse) {
        let request = NetworkRequest<CityWeatherData>.currentWeather(city: city)
        httpsClient.load(networkRequest: request).sink { reqCompletion in
            if case let .failure(error) = reqCompletion {
                completion(nil, error)
            }
        } receiveValue: { data in
            completion(data, nil)
        }
        .store(in: &cancellables)
    }
     */
}
