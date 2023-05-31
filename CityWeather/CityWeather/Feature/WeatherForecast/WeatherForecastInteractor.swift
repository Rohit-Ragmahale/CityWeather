//
//  WeatherForecastInteractor.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol WeatherForecastInteractorInterface {
    func searchWeatherForecastForCity()
    func getCityName() -> String?
}

final class WeatherForecastInteractor {
    private var presenter: WeatherForecastPresenterInterface?
    private var service: WeatherForecastServiceProvider?
    private var cityCode: String?
    private var city: String?
    
    init(presenter: WeatherForecastPresenterInterface? = nil, cityCode: String? = nil, city: String? = nil, service: WeatherForecastServiceProvider? = nil) {
        self.presenter = presenter
        self.service = service
        self.cityCode = cityCode
        self.city = city
    }
}

extension WeatherForecastInteractor: WeatherForecastInteractorInterface {
    func getCityName() -> String? {
        city
    }
    
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

