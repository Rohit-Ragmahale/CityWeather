//
//  WeatherSearchPresenter.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol WeatherSearchPresenterInterface {
    func weatherListUpdated()
}

final class WeatherSearchPresenter {
    var view: WeatherSearchPresenterInterface?
    
}
