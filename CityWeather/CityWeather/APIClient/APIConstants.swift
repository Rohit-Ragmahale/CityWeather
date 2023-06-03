//
//  WeatherAPIConstants.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

// MARK: Weather API Constants
// API Documentation here: https://openweathermap.org/api
struct WeatherAPIConstants {
    // MARK: Base URL
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    // MARK: Services
    static let weatherService = "/weather"
    static let forcastService = "/forecast"
    // MARK: API Key
    static let apiId = "7eaab9424f40d70b55d21a995bc1bd4c"
    // MARK: Data Unit
    // We are considering 'metric' unit for this app
    // Other unit info: https://openweathermap.org/current#data
    static let metric = "metric"

    // MARK: API Query Parameters
    struct QueryParameters {
        static let appid = "appid"
        static let units = "units"
        static let cityId = "id"
        static let city = "q"
    }
}
