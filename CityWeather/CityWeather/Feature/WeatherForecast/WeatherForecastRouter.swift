//
//  WeatherForecastRouter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

protocol WeatherForecastRouting {
}

struct WeatherForecastRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
}

extension WeatherForecastRouter: WeatherForecastRouting {

}

