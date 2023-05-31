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
        let interactor = WeatherSearchInteractor()
        let presenter = WeatherSearchPresenter()

        // Router -> ViewController
        let router = WeatherSearchRouter(viewController: viewController)

        // ViewController -> Interactor
        viewController.interactor = interactor

        // Interactor -> Presenter
        interactor.presenter = presenter
        interactor.service = service

        // Presenter -> Router
        presenter.router = router
        // Presenter -> ViewController
        presenter.view = viewController

        return viewController
    }
}
