//
//  WeatherSearchInteractor.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol WeatherSearchInteractorInterface {
    func searchWeatherForCity(city: String)
    func showWeatherForecastForCityAt(index: Int)
}

final class WeatherSearchInteractor {
    private var cityList: [CityWeatherData] = []

    var service: WeatherServiceProvider?
    var presenter: WeatherSearchPresenterInterface?
}

extension WeatherSearchInteractor: WeatherSearchInteractorInterface {
    func showWeatherForecastForCityAt(index: Int) {
        let city = cityList[index]
        presenter?.showWeatherForecastForCity(city: city.name ?? "", cityId: "\(city.id)")
    }

    func searchWeatherForCity(city: String) {
        service?.fetchWeatherFor(city: city) { [weak self] cityWeatherData, responseError in
            if let responseError = responseError {
                DispatchQueue.main.async {
                    self?.presenter?.weatherRequestFailed(description: responseError.errorDescription)
                }
            } else {
                if let cityWeatherData = cityWeatherData {
                    self?.cityList.insert(cityWeatherData, at: 0)
                }
                DispatchQueue.main.async {
                    self?.presenter?.weatherListUpdated(list: self?.cityList ?? [])
                }
            }
        }
    }
}
