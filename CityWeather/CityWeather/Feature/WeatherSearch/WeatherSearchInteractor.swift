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
    private let service: WeatherServiceProvider
    private let presenter: WeatherSearchPresenterInterface
    private let dataProvider: DataProvider

    init(dataProvider: DataProvider,
         service: WeatherServiceProvider,
         presenter: WeatherSearchPresenterInterface) {
        self.service = service
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
}

extension WeatherSearchInteractor: WeatherSearchInteractorInterface {
    func showWeatherForecastForCityAt(index: Int) {
        if let ciryWeather = dataProvider.weatherDataAt(index: index) {
            presenter.showWeatherForecastForCity(city: ciryWeather.name ?? "",
                                                  cityId: "\(ciryWeather.id)",
                                                  dataStore: dataProvider)
        }
    }

    func searchWeatherForCity(city: String) {
        guard !dataProvider.weatherPresentForCity(city: city) else {
            DispatchQueue.main.async {
                self.presenter.weatherListUpdated(list: self.dataProvider.weatherDataList)
            }
            return
        }
        service.fetchWeatherFor(city: city) { [weak self] cityWeatherData, responseError in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                if let responseError = responseError {
                    weakSelf.presenter.weatherRequestFailed(description: responseError.errorDescription)
                } else if let cityWeatherData = cityWeatherData {
                    weakSelf.dataProvider.addWeatherData(weather: cityWeatherData)
                    weakSelf.presenter.weatherListUpdated(list: weakSelf.dataProvider.weatherDataList)
                }
            }
        }
    }
}
