//
//  WeatherSearchRouter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

protocol WeatherSearchRouting {
    func showWeatherForcast(cityCode: String)
}

struct WeatherSearchRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
}

extension WeatherSearchRouter: WeatherSearchRouting {
    func showWeatherForcast(cityCode: String) {
        let configurator = WeatherForecastConfigurator(service: WeatherForecastService(httpsClient: HTTPClient.makeHTTPClient()),
                                                       cityCode: cityCode)
        let forecastVC = configurator.configureViewController()
        DispatchQueue.main.async {
            self.viewController?.present(forecastVC, animated: true)
        }
    }
}
