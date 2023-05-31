//
//  WeatherForecastViewController.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

protocol WeatherForecastViewInterfaces: AnyObject {
    func showWeatherForecast(list: [DayForecast])
    func showErrorAlert(errorMessage: String)
}

class WeatherForecastViewController: UIViewController {
    var interactor: WeatherForecastInteractorInterface?
    var router: WeatherForecastRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.searchWeatherForecastForCity()
    }
}

extension WeatherForecastViewController: WeatherForecastViewInterfaces {
    func showWeatherForecast(list: [DayForecast]) {
        
    }
    
    func showErrorAlert(errorMessage: String) {
        
    }
}
