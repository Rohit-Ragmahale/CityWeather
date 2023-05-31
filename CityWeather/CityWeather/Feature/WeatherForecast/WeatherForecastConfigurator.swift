//
//  WeatherForecastConfigurator.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

struct WeatherForecastConfigurator: Configurator {
    private let service: WeatherForecastServiceProvider
    private let cityId: String
    private let city: String
    
    init(service: WeatherForecastServiceProvider, city: String, cityId: String) {
        self.service = service
        self.cityId = cityId
        self.city = city
    }
    
    func configureViewController() -> UIViewController {
        let viewController: WeatherForecastViewController = UIStoryboard.instantiate(identifier: .weatherForecast)
        
        // Presenter -> ViewController
        let presenter = WeatherForecastPresenter(view: viewController)

        // Interactor -> Presenter
        let interactor = WeatherForecastInteractor(presenter: presenter, cityId: cityId, city: city, service: service)
        
        // Router -> ViewController
        let router = WeatherForecastRouter(viewController: viewController)
        
        // ViewController -> Interactor
        viewController.interactor = interactor
        viewController.router = router
    
        return viewController
    }
}

