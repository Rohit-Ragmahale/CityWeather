//
//  WeatherForecastInteractor.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol WeatherForecastInteractorInterface {
    func searchWeatherForecastForCity()
}

final class WeatherForecastInteractor {
    var cityCode: String?
    var service: WeatherForecastServiceProvider?
    var presenter: WeatherForecastPresenterInterface?
}

extension WeatherForecastInteractor: WeatherForecastInteractorInterface {

    
    func searchWeatherForecastForCity() {
        service?.fetchWeatherForecastFor(cityCode: cityCode ?? "", completion: { futureForecasts, responseError in
            if let responseError = responseError {
                DispatchQueue.main.async {
                    self.presenter?.weatherForecastRequestFailed(description: responseError.errorDescription)
                }
            }
            print("forecastList \(futureForecasts ?? [])")
            DispatchQueue.main.async {
                self.presenter?.weatherForecatsListUpdated(list: futureForecasts ?? [])
            }
        })
    }
}

