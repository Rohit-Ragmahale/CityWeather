//
//  DataProvider.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 18/09/23.
//

import Foundation

// MARK: - Data Provider Interface
protocol DataProvider {
    func addWeatherData(weather: CityWeatherData)
    func addForecatsForCity(cityId: String, forecast: [DayForecast])
    func weatherPresentForCity(city: String) -> Bool
    func forecastForCity(cityId: String) -> [DayForecast]?
    func weatherDataAt(index: Int) -> CityWeatherData?
    var weatherDataList: [CityWeatherData] { get }
}
