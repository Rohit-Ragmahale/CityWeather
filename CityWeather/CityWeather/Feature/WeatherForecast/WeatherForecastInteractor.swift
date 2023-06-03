//
//  WeatherForecastInteractor.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

// MARK: - WeatherForecastInteractor Interface
protocol WeatherForecastInteractorInterface {
    func searchWeatherForecastForCity()
    var currentCity: String? { get }
}

final class WeatherForecastInteractor {
    // MARK: - Properties
    private let presenter: WeatherForecastPresenterInterface
    private let service: WeatherForecastServiceProvider
    private let cityId: String
    private let city: String
    private let dataStore: DataProvider

    // MARK: - Custom Initializer
    init(presenter: WeatherForecastPresenterInterface,
         cityId: String,
         city: String,
         service: WeatherForecastServiceProvider,
         dataStore: DataProvider) {
        self.presenter = presenter
        self.service = service
        self.cityId = cityId
        self.city = city
        self.dataStore = dataStore
    }
}

// MARK: - WeatherForecastInteractor Interface Implementation
extension WeatherForecastInteractor: WeatherForecastInteractorInterface {
    var currentCity: String? {
        city
    }

    func searchWeatherForecastForCity() {
        if let forecast = dataStore.forecastForCity(cityId: cityId) {
            presenter.weatherForecatsListUpdated(list: forecast )
            return
        }
        service.fetchWeatherForecastFor(cityId: cityId,
                                         completion: { futureForecasts, responseError in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if let responseError = responseError {
                    self.presenter.weatherForecastRequestFailed(description: responseError.errorDescription)
                } else {
                    guard let futureForecasts = futureForecasts else { return }
                    self.dataStore.addForecatsForCity(cityId: cityId, forecast: futureForecasts)
                    self.presenter.weatherForecatsListUpdated(list: futureForecasts)
                }
            }
        })
    }
}
