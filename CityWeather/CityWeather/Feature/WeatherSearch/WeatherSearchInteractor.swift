//
//  WeatherSearchInteractor.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol WeatherSearchInteractorInterface {
    func searchWeatherForCity(city: String)
}

final class WeatherSearchInteractor {
    private var cityList: [CityWeatherData] = []

    var service: WeatherServiceProvider?
    var presenter: WeatherSearchPresenterInterface?
}

extension WeatherSearchInteractor: WeatherSearchInteractorInterface {
    func searchWeatherForCity(city: String) {
        service?.fetchWeatherFor(city: city) { cityWeatherData, responseError in
            if let responseError = responseError {
                DispatchQueue.main.async {
                    self.presenter?.weatherRequestFailed(description: responseError.errorDescription)
                }
            }
            if let cityWeatherData = cityWeatherData {
                self.cityList.append(cityWeatherData)
            }
            DispatchQueue.main.async {
                self.presenter?.weatherListUpdated(list: self.cityList)
            }
        }
    }
}
