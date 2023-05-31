//
//  WeatherSearchInteractor.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol WeatherSearchInteractorInterface {
    func searchWeatherForCity(city: String)
    func cityCodeforCity(index: Int) -> Int
}

final class WeatherSearchInteractor {
    private var cityList: [CityWeatherData] = []

    var service: WeatherServiceProvider?
    var presenter: WeatherSearchPresenterInterface?
}

extension WeatherSearchInteractor: WeatherSearchInteractorInterface {
    func cityCodeforCity(index: Int) -> Int {
        cityList[index].id
    }
    
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
