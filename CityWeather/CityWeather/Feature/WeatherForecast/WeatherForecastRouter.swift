//
//  WeatherForecastRouter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

// MARK: - WeatherForecastRouting Interface
// Intentionally kept empty, useful in future implementation.
protocol WeatherForecastRouting {}

struct WeatherForecastRouter {
    // MARK: - Properties
    private weak var viewController: UIViewController?

    // MARK: - Custom Initializer
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - WeatherForecastRouting Interface Implementation
extension WeatherForecastRouter: WeatherForecastRouting {}
