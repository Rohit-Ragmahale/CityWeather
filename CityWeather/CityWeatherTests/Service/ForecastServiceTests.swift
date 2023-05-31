//
//  ForecastServiceTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class TestWeatherForecastService: XCTestCase {
    var forecastService: WeatherForecastService?

    override func setUp() {
        super.setUp()
        forecastService = WeatherForecastService(httpsClient: MockHTTPClient())
    }

    override func tearDown() {
        super.tearDown()
        forecastService = nil
    }

    func testForecastSuccessResponse() {
        // given
        let expectation = XCTestExpectation(description: "\(#function)-FetchForecastExpectation")
        // when
        forecastService?.fetchWeatherForecastFor(cityId: "100", completion: { (futureForecasts, responseError) in
            if responseError != nil {
                XCTFail("Failed to fetch forecast")
            } else {
                expectation.fulfill()
                XCTAssertEqual(futureForecasts?.count, 40)
            }
        })
        wait(for: [expectation], timeout: 0.3)
    }
}
