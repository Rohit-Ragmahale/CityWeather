//
//  DataStoreTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import XCTest
@testable import CityWeather

final class DataStoreTests: XCTestCase {

    var dataStore: DataStore!

    override func setUp() {
        super.setUp()
        dataStore = DataStore()
    }

    override func tearDown() {
        super.tearDown()
        dataStore = nil
    }

    func testDataStore_addWeatherData() {
        // given
        guard let weather = MockProvider.getCityWeatherData() else {
            XCTFail("Failed to generate mock")
            return
        }
        XCTAssertTrue(dataStore.weatherDataList.isEmpty)

        // when
        dataStore.addWeatherData(weather: weather)

        // then
        XCTAssertTrue(dataStore.weatherPresentForCity(city: weather.name ?? ""))
        XCTAssertFalse(dataStore.weatherDataList.isEmpty)

        XCTAssertEqual(dataStore.weatherDataList.count, 1)
    }

    func testDataStore_addWeatherData_DoubleEntry() {
        // given
        guard let weather = MockProvider.getCityWeatherData() else {
            XCTFail("Failed to generate mock")
            return
        }
        XCTAssertTrue(dataStore.weatherDataList.isEmpty)

        // when
        dataStore.addWeatherData(weather: weather)

        // then
        XCTAssertEqual(dataStore.weatherDataList.count, 1)

        // when
        dataStore.addWeatherData(weather: weather)

        // then
        XCTAssertEqual(dataStore.weatherDataList.count, 1)
        XCTAssertNotNil(dataStore.weatherDataAt(index: 0))
    }

    func testDataStore_addForecatsForCity() {
        // given
        guard let weather = MockProvider.getCityWeatherData() else {
            XCTFail("Failed to generate mock")
            return
        }
        dataStore.addWeatherData(weather: weather)

        guard let forecast = MockProvider.getFutureForecastsData() else {
            XCTFail("Failed to generate mock")
            return
        }
        // when
        dataStore.addForecatsForCity(cityId: "\(weather.id)", forecast: forecast)

        // then
        XCTAssertNotNil(dataStore.forecastForCity(cityId: "\(weather.id)"))
    }
}
