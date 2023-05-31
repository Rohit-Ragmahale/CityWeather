//
//  WeatherForecastConfigurator.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

struct WeatherForecastConfigurator: Configurator {
    private let service: WeatherForecastServiceProvider
    private let cityCode: String
    
    init(service: WeatherForecastServiceProvider, cityCode: String) {
        self.service = service
        self.cityCode = cityCode
    }
    
    func configureViewController() -> UIViewController {
        let viewController: WeatherForecastViewController = UIStoryboard.instantiate(identifier: .weatherForecast)
        let interactor = WeatherForecastInteractor()
        let presenter = WeatherForecastPresenter()
        
        // Router -> ViewController
        let router = WeatherForecastRouter(viewController: viewController)
        
        // ViewController -> Interactor
        viewController.interactor = interactor
        viewController.router = router
        
        // Interactor -> Presenter
        interactor.presenter = presenter
        interactor.service = service
        interactor.cityCode = cityCode
        
        // Presenter -> Router
        presenter.router = router
        // Presenter -> ViewController
        presenter.view = viewController
    
        return viewController
    }
}

