//
//  WeatherServiceTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class WeatherServiceTests: XCTestCase {
    var weatherService: WeatherService?

    override func setUp() {
        super.setUp()
        weatherService = WeatherService(httpsClient: MockHTTPClient())
    }

    override func tearDown() {
        super.tearDown()
        weatherService = nil
    }

    func testWeatherSuccessResponse() throws {
        // given
        let expectation = XCTestExpectation(description: "\(#function)-FetchWeatherExpectation")
        // when
        weatherService?.fetchWeatherFor(city: "Leeds") {  cityWeatherData, responseError in
            if responseError != nil {
                XCTFail("Failed to fetch forecast")
            } else {
                expectation.fulfill()
                XCTAssertEqual(cityWeatherData?.name, "Leeds")
            }
        }
        wait(for: [expectation], timeout: 0.3)
    }
}
