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

class WeatherSearchRouter {
    weak var viewController: UIViewController?
}

extension WeatherSearchRouter: WeatherSearchRouting {
    func showWeatherForcast(cityCode: String) {
        
    }
}
