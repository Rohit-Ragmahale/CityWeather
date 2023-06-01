//
//  MockProvider.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import Foundation
@testable import CityWeather

final class MockProvider {
    static func getCityWeatherData() -> CityWeatherData? {
        if let data = try? TestUtils.data(forResource: "CityWeatherDataResponse") {
            if let cityWeatherData = try? JSONDecoder().decode(CityWeatherData.self, from: data) {
                return cityWeatherData
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    static func getFutureForecastsData() -> [DayForecast]? {
        if let data = try? TestUtils.data(forResource: "ForecastResponse") {
            if let cityWeatherData = try? JSONDecoder().decode(FutureForecasts.self, from: data) {
                return cityWeatherData.list
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
