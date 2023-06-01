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
            if let dayForecast = MockProvider.getFutureForecastsData()?.first {
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
}
