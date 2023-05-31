//
//  CityWeatherDataTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class CityWeatherDataTests: XCTestCase {

    func testFutureForecastsParsing() throws {
        // given
        if let cityWeatherData = try getCityWeatherDataObject() {
            // then
            XCTAssertEqual(cityWeatherData.name, "Leeds")
            XCTAssertEqual(cityWeatherData.id, 3333164)
            XCTAssertEqual(cityWeatherData.forecast.weatherDescription, "broken clouds")
        } else {
            XCTFail("CityWeatherDataResponse to CityWeatherData parsing failed")
        }
    }

    func testCompareCityWeatherDataEquality() throws {
        // given
        let obj1 = try getCityWeatherDataObject()
        let obj2 = try getCityWeatherDataObject()
        // then
        XCTAssertTrue(obj1 == obj2)

        // whne
        obj2?.id = 100
        // then
        XCTAssertTrue(obj1 == obj2)

        // when
        obj2?.name = "Other name"
        // then
        // Equality tested only on Name
        XCTAssertFalse(obj1 == obj2)
    }

    private func getCityWeatherDataObject() throws -> CityWeatherData? {
        let data = try TestUtils.data(forResource: "CityWeatherDataResponse")
        let cityWeatherData = try? JSONDecoder().decode(CityWeatherData.self, from: data)
        return cityWeatherData ?? nil
    }
}
