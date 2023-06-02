//
//  WeatherForecastRouter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

// Intentionally kept empty, useful in future implementation.
protocol WeatherForecastRouting {}

struct WeatherForecastRouter {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension WeatherForecastRouter: WeatherForecastRouting {}
