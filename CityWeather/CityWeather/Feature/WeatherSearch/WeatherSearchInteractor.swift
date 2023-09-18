//
//  WeatherSearchInteractor.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

// MARK: - WeatherSearchInteractor Interface
protocol WeatherSearchInteractorInterface {
    func searchWeatherForCity(city: String)
    func showWeatherForecastForCityAt(index: Int)
}

struct WeatherSearchInteractor {
    // MARK: - Properties
    private let service: WeatherServiceProvider
    private let presenter: WeatherSearchPresenterInterface
    private let dataProvider: DataProvider

    // MARK: - Custom Initializer
    init(dataProvider: DataProvider,
         service: WeatherServiceProvider,
         presenter: WeatherSearchPresenterInterface) {
        self.service = service
        self.presenter = presenter
        self.dataProvider = dataProvider
    }
}

// MARK: - WeatherSearchInteractor Interface Implementation
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
            self.presenter.weatherListUpdated(list: self.dataProvider.weatherDataList)
            return
        }
        Task {
            do {
                if let cityWeatherData = try await service.fetchWeatherFor(city: city) {
                    dataProvider.addWeatherData(weather: cityWeatherData)
                    presenter.weatherListUpdated(list: dataProvider.weatherDataList)
                }
            } catch let error as ResponseError {
                presenter.weatherRequestFailed(description: error.errorDescription)
            }
        }
    }

    /*
    func searchWeatherForCity(city: String) {
        guard !dataProvider.weatherPresentForCity(city: city) else {
            self.presenter.weatherListUpdated(list: self.dataProvider.weatherDataList)
            return
        }
    
        service.fetchWeatherFor(city: city) { cityWeatherData, responseError in
            if let responseError = responseError {
                presenter.weatherRequestFailed(description: responseError.errorDescription)
            } else if let cityWeatherData = cityWeatherData {
                dataProvider.addWeatherData(weather: cityWeatherData)
                presenter.weatherListUpdated(list: dataProvider.weatherDataList)
            }
        }
    }
    */
}
