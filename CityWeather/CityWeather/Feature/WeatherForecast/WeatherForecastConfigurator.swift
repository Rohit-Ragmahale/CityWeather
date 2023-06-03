//
//  WeatherForecastConfigurator.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

struct WeatherForecastConfigurator {
    // MARK: - Properties
    private let service: WeatherForecastServiceProvider
    private let cityId: String
    private let city: String
    private let dataStore: DataProvider

    // MARK: - Custom Initializer
    init(service: WeatherForecastServiceProvider, city: String, cityId: String, dataStore: DataProvider) {
        self.service = service
        self.cityId = cityId
        self.city = city
        self.dataStore = dataStore
    }
}

// MARK: - WeatherForecastView Configuration Implementation
extension WeatherForecastConfigurator: Configurator {
    func configureViewController() -> UIViewController {
        let viewController: WeatherForecastViewController = UIStoryboard.instantiate(identifier: .weatherForecast)

        // Router -> ViewController (weak)
        let router = WeatherForecastRouter(viewController: viewController)

        // Presenter -> ViewController (weak)
        // Presenter -> Router
        let presenter = WeatherForecastPresenter(view: viewController, router: router)

        // Interactor -> Presenter
        let interactor = WeatherForecastInteractor(presenter: presenter,
                                                   cityId: cityId,
                                                   city: city,
                                                   service: service,
                                                   dataStore: dataStore)

        // ViewController -> Interactor
        viewController.interactor = interactor

        return viewController
    }
}
