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
        Task {
            do {
                let futureForecasts = try await forecastService?.fetchWeatherForecastFor(cityId: "100")
                expectation.fulfill()
                XCTAssertEqual(futureForecasts?.count, 40)
            } catch {
                XCTFail("Failed to fetch forecast")
            }
        }
        wait(for: [expectation], timeout: 0.3)
    }
}
