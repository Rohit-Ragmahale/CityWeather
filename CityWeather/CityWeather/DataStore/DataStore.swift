//
//  DataStore.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import Foundation

protocol DataProvider {
    func addWeatherData(weather: CityWeatherData)
    func addForecatsForCity(cityId: String, forecast: [DayForecast])
    func weatherPresentForCity(city: String) -> Bool
    func forecastForCity(cityId: String) -> [DayForecast]?
    func weatherDataAt(index: Int) -> CityWeatherData?
    var weatherDataList: [CityWeatherData] { get }
}

class DataStore {
    private var data: [CityWeatherData] = []
}

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
        data.first(where: { $0.name == city }) != nil
    }

    func forecastForCity(cityId: String) -> [DayForecast]? {
        data.first(where: { "\($0.id)" == cityId })?.futureForecast
    }

    func weatherDataAt(index: Int) -> CityWeatherData? {
        data[index]
    }
}
