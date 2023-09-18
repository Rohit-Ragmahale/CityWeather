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
        Task {
            do {
                if let cityWeatherData = try await weatherService?.fetchWeatherFor(city: "Leeds") {
                    expectation.fulfill()
                    XCTAssertEqual(cityWeatherData.name, "Leeds")
                }
            } catch _ as ResponseError {
                XCTFail("Failed to fetch forecast")
            }
        }
        wait(for: [expectation], timeout: 0.3)
    }
}
