//
//  WeatherForecastCellTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import XCTest
@testable import CityWeather

final class WeatherForecastCellTests: XCTestCase {
    func testWeatherForecast() {
        let nib = UINib(nibName: "WeatherForecastCell", bundle: Bundle(for: WeatherForecastCell.self))
        if let cell = nib.instantiate(withOwner: self, options: nil).first as? WeatherForecastCell {
            if let dayForecast = getFutureForecastsData() {
                cell.inflateWith(forecast: dayForecast)
                XCTAssertEqual(cell.accessoryType, .none)
                XCTAssertEqual(cell.backgroundColor?.cgColor, Theme.HomePage.cityWeatherBGColor.cgColor)
            } else {
                XCTFail("Unable to parse ForecastResponse mock file")
            }
        } else {
            XCTFail("Unable to instantiate WeatherForecastCell")
        }
    }

    private func getFutureForecastsData() -> DayForecast? {
        if let data = try? TestUtils.data(forResource: "ForecastResponse") {
            if let cityWeatherData = try? JSONDecoder().decode(FutureForecasts.self, from: data) {
                return cityWeatherData.list.first
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
