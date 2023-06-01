//
//  WeatherForecastPresenter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol WeatherForecastPresenterInterface: AnyObject {
    func weatherForecatsListUpdated(list: [DayForecast])
    func weatherForecastRequestFailed(description: String)
}

final class WeatherForecastPresenter {
    private weak var view: WeatherForecastViewInterfaces?
    private var router: WeatherForecastRouting

    init(view: WeatherForecastViewInterfaces? = nil, router: WeatherForecastRouting) {
        self.view = view
        self.router = router
    }
}

extension WeatherForecastPresenter: WeatherForecastPresenterInterface {
    func weatherForecatsListUpdated(list: [DayForecast]) {
        view?.showWeatherForecast(list: list)
    }

    func weatherForecastRequestFailed(description: String) {
        view?.showErrorAlert(errorMessage: description)
    }
}
