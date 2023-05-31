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
    
    init(view: WeatherForecastViewInterfaces? = nil) {
        self.view = view
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
