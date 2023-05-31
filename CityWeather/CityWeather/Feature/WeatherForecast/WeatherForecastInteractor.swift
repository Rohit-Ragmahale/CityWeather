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
    private var cityId: String?
    private var city: String?

    init(presenter: WeatherForecastPresenterInterface? = nil,
         cityId: String? = nil,
         city: String? = nil,
         service: WeatherForecastServiceProvider? = nil) {
        self.presenter = presenter
        self.service = service
        self.cityId = cityId
        self.city = city
    }
}

extension WeatherForecastInteractor: WeatherForecastInteractorInterface {
    func getCityName() -> String? {
        city
    }

    func searchWeatherForecastForCity() {
        service?.fetchWeatherForecastFor(cityId: cityId ?? "",
                                         completion: { [weak self] futureForecasts, responseError in
            DispatchQueue.main.async {
                if let responseError = responseError {
                    self?.presenter?.weatherForecastRequestFailed(description: responseError.errorDescription)
                } else {
                    self?.presenter?.weatherForecatsListUpdated(list: futureForecasts ?? [])
                }
            }
        })
    }
}
