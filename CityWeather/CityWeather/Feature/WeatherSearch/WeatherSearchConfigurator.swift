//
//  WeatherSearchConfigurator.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

protocol Configurator {
    func configureViewController() -> UIViewController
}

struct WeatherSearchConfigurator {
    // MARK: - Properties
    private let service: WeatherServiceProvider
    private let dataStore: DataProvider

    // MARK: - Custom Initializer
    init(service: WeatherServiceProvider, dataStore: DataProvider) {
        self.service = service
        self.dataStore = dataStore
    }
}

// MARK: - WeatherSearchView Configuration Implementation
extension WeatherSearchConfigurator: Configurator {
    func configureViewController() -> UIViewController {
        let viewController: WeatherSearchViewController = UIStoryboard.instantiate(identifier: .weatherSearch)

        // Router -> ViewController (weak)
        let router = WeatherSearchRouter(viewController: viewController)

        // Presenter -> Router
        // Presenter -> ViewController (weak)
        let presenter = WeatherSearchPresenter(view: viewController, router: router)

        // Interactor -> Presenter
        let interactor = WeatherSearchInteractor(dataProvider: dataStore,
                                                 service: service,
                                                 presenter: presenter)

        // ViewController -> Interactor
        viewController.interactor = interactor

        return viewController
    }
}
