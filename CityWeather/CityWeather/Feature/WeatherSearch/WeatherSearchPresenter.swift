//
//  WeatherSearchPresenter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation
// MARK: - WeatherSearchPresenter Interface
protocol WeatherSearchPresenterInterface {
    func weatherListUpdated(list: [CityWeatherData])
    func weatherRequestFailed(description: String)
    func showWeatherForecastForCity(city: String, cityId: String, dataStore: DataProvider)
}

struct WeatherSearchPresenter {
    // MARK: - Properties
    private weak var view: WeatherSearchViewInterfaces?
    private var router: WeatherSearchRouting

    // MARK: - Custom Initializer
    init(view: WeatherSearchViewInterfaces?, router: WeatherSearchRouting) {
        self.view = view
        self.router = router
    }
}

// MARK: - WeatherSearchPresenter Interface Implementation
extension WeatherSearchPresenter: WeatherSearchPresenterInterface {
    func showWeatherForecastForCity(city: String, cityId: String, dataStore: DataProvider) {
        DispatchQueue.main.async {
            router.showWeatherForcast(city: city, cityId: cityId, dataStore: dataStore)
        }
    }
    func weatherListUpdated(list: [CityWeatherData]) {
        DispatchQueue.main.async {
            view?.showWeatherList(list: list)
        }
    }

    func weatherRequestFailed(description: String) {
        DispatchQueue.main.async {
            view?.showErrorAlert(errorMessage: description)
        }
    }
}
