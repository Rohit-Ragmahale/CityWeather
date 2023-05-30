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
    private let inetractor: WeatherSearchInteractorInterface
    private let presenter: WeatherSearchPresenterInterface
    private let router: WeatherSearchRouting

    init(service: WeatherServiceProvider, inetractor: WeatherSearchInteractorInterface, presenter: WeatherSearchPresenterInterface, router: WeatherSearchRouting) {
        self.service = service
        self.inetractor = inetractor
        self.presenter = presenter
        self.router = router
    }
    
    func configureViewController() -> UIViewController {
        let viewController: WeatherSearchViewController = UIStoryboard.instantiate(identifier: .weatherSearch)
        let interactor = WeatherSearchInteractor()
        let presenter = WeatherSearchPresenter()
        let router = WeatherSearchRouter()
        
        // ViewController -> Interactor
        viewController.interactor = interactor
        
        // Interactor -> Presenter
        interactor.presenter = presenter
        interactor.service = service
        
        // Presenter -> Router
        presenter.router = router
        // Presenter -> ViewController
        presenter.view = viewController
        
        // Router -> ViewController
        router.viewController = viewController
    
        return viewController
    }
}
