//
//  WeatherAPIConstants.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

struct WeatherAPIConstants {
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    static let weatherService = "/weather"
    static let forcastService = "/forecast"
    static let apiId = "7eaab9424f40d70b55d21a995bc1bd4c"
    static let metric = "metric"

    struct QueryParameters {
        static let appid = "appid"
        static let units = "units"
        static let cityId = "id"
        static let city = "q"
    }
}
