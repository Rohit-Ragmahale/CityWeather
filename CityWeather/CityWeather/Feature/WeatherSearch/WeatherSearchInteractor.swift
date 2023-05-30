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
    var presenter: WeatherSearchPresenterInterface?
    
}

extension WeatherSearchInteractor: WeatherSearchInteractorInterface {
    func searchWeatherForCity(city: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.presenter?.weatherListUpdated(list: [CityWeatherData(name: "Leeds")])
        })
    }
}
