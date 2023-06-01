//
//  WeatherSearchRouter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

protocol WeatherSearchRouting {
    func showWeatherForcast(city: String, cityId: String, dataStore: DataProvider)
}

struct WeatherSearchRouter {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension WeatherSearchRouter: WeatherSearchRouting {
    func showWeatherForcast(city: String, cityId: String, dataStore: DataProvider) {
        #if WEATHER_FORECAST_DETAILS
        let service = WeatherForecastService(httpsClient: HTTPClient.makeHTTPClient())
        let configurator = WeatherForecastConfigurator(service: service,
                                                       city: city,
                                                       cityId: cityId,
                                                       dataStore: dataStore)
        let forecastVC = configurator.configureViewController()
        DispatchQueue.main.async {
            self.viewController?.navigationController?.pushViewController(forecastVC, animated: true)
        }
        #endif
    }
}
