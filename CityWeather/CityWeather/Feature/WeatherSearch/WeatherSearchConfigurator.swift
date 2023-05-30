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
    func configureViewController() -> UIViewController {

        let viewController: WeatherSearchViewController = UIStoryboard.instantiate(identifier: .weatherSearch)
        let interactor = WeatherSearchInteractor()
        let presenter = WeatherSearchPresenter()
        
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
    
        return viewController
    }
}
