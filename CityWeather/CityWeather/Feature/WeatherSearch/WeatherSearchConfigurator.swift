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

struct WeatherSearchConfigurator: Configurator {
    private let service: WeatherServiceProvider

    init(service: WeatherServiceProvider) {
        self.service = service
    }

    func configureViewController() -> UIViewController {
        let viewController: WeatherSearchViewController = UIStoryboard.instantiate(identifier: .weatherSearch)
        // Router -> ViewController (weak)
        let router = WeatherSearchRouter(viewController: viewController)

        // Presenter -> Router
        // Presenter -> ViewController (weak)
        let presenter = WeatherSearchPresenter(view: viewController, router: router)

        // Interactor -> Presenter
        let interactor = WeatherSearchInteractor(service: service, presenter: presenter)

        // ViewController -> Interactor
        viewController.interactor = interactor

        return viewController
    }
}
