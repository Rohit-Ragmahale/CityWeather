//
//  WeatherSearchPresenter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation
// MARK: - WeatherSearchPresenter Interface
protocol WeatherSearchPresenterInterface: AnyObject {
    func weatherListUpdated(list: [CityWeatherData])
    func weatherRequestFailed(description: String)
    func showWeatherForecastForCity(city: String, cityId: String, dataStore: DataProvider)
}

final class WeatherSearchPresenter {
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
        router.showWeatherForcast(city: city, cityId: cityId, dataStore: dataStore)
    }
    func weatherListUpdated(list: [CityWeatherData]) {
        view?.showWeatherList(list: list)
    }

    func weatherRequestFailed(description: String) {
        view?.showErrorAlert(errorMessage: description)
    }
}
