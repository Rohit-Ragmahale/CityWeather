//
//  WeatherForecastPresenter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

// MARK: - WeatherForecastPresenter Interface
protocol WeatherForecastPresenterInterface {
    func weatherForecatsListUpdated(list: [DayForecast])
    func weatherForecastRequestFailed(description: String)
}

struct WeatherForecastPresenter {
    // MARK: - Properties
    private weak var view: WeatherForecastViewInterfaces?
    private var router: WeatherForecastRouting

    // MARK: - Custom Initializer
    init(view: WeatherForecastViewInterfaces? = nil, router: WeatherForecastRouting) {
        self.view = view
        self.router = router
    }
}

// MARK: - WeatherForecastPresenter Interface Implementation
extension WeatherForecastPresenter: WeatherForecastPresenterInterface {
    func weatherForecatsListUpdated(list: [DayForecast]) {
        view?.showWeatherForecast(list: list)
    }

    func weatherForecastRequestFailed(description: String) {
        view?.showErrorAlert(errorMessage: description)
    }
}
