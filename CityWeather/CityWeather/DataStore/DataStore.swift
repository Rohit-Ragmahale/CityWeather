//
//  DataStore.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 01/06/2023.
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

// MARK: - DataStore
final class DataStore {
    // MARK: - Properties
    private var data: [CityWeatherData] = []
}

// MARK: - Data Provider Interface Implementation
extension DataStore: DataProvider {
    var weatherDataList: [CityWeatherData] {
        data
    }

    func addWeatherData(weather: CityWeatherData) {
        guard data.first(where: { $0.id == weather.id }) == nil else {
            return
        }
        data.insert(weather, at: 0)
    }

    func addForecatsForCity(cityId: String, forecast: [DayForecast]) {
        guard let weather = data.first(where: { "\($0.id)" == cityId }) else {
            return
        }
        weather.futureForecast = forecast
    }

    func weatherPresentForCity(city: String) -> Bool {
        data.first(where: { $0.name?.lowercased() == city.lowercased() }) != nil
    }

    func forecastForCity(cityId: String) -> [DayForecast]? {
        data.first(where: { "\($0.id)" == cityId })?.futureForecast
    }

    func weatherDataAt(index: Int) -> CityWeatherData? {
        data[index]
    }
}
