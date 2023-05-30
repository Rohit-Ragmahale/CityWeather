//
//  WeatherSearchPresenter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol WeatherSearchPresenterInterface: AnyObject {
    func weatherListUpdated(list: [CityWeatherData])
    func weatherRequestFailed(description: String)
}

final class WeatherSearchPresenter {
    weak var view: WeatherSearchViewInterfaces?
    var router: WeatherSearchRouting?
}

extension WeatherSearchPresenter: WeatherSearchPresenterInterface {
    func weatherListUpdated(list: [CityWeatherData]) {
        view?.showWeatherList(list: list)
    }
    
    func weatherRequestFailed(description: String) {
        view?.showErrorAlert(errorMessage: description)
    }
}
