//
//  TestFutureForecasts.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class TestFutureForecasts: XCTestCase {

    func testFutureForecastsParsing() throws {
        // given
        let data = try TestUtils.data(forResource: "ForecastResponse")
        // when
        let forecast = try? JSONDecoder().decode(FutureForecasts.self, from: data)
        // then
        if let forecast = forecast {
            XCTAssertEqual(forecast.list.count, 40)
        } else {
            XCTFail("ForecastResponse to FutureForecasts parsing failed")
        }
    }
}
