//
//  CityWeatherCellTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import XCTest
@testable import CityWeather

final class CityWeatherCellTests: XCTestCase {
    func testCityWeatherCell() {
        let nib = UINib(nibName: "CityWeatherCell", bundle: Bundle(for: CityWeatherCell.self))
        if let cell = nib.instantiate(withOwner: self, options: nil).first as? CityWeatherCell {
            if let weateherData = getCityWeatherData() {
                cell.inflateWith(weather: weateherData)
                let expextedValue = "Leeds.\nbroken clouds.\nTemperature: 12.99.\nHumidity: 74.0.\nTap to view forecast"
                XCTAssertEqual(cell.accessibilityLabel, expextedValue)
                #if WEATHER_FORECAST_DETAILS
                XCTAssertEqual(cell.accessoryType, .disclosureIndicator)
                #else
                XCTAssertEqual(cell.accessoryType, .none)
                #endif
                XCTAssertEqual(cell.backgroundColor?.cgColor, Theme.HomePage.cityWeatherBGColor.cgColor)
            } else {
                XCTFail("Unable to parse CityWeatherCell mock file")
            }
        } else {
            XCTFail("Unable to instantiate CityWeatherCell")
        }
    }

    private func getCityWeatherData() -> CityWeatherData? {
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
}
