//
//  ResponseErrorTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class ResponseErrorTests: XCTestCase {

    func testResponseError() {
        XCTAssertEqual(ResponseError.decode.errorDescription, "City weather data not found.")
        XCTAssertEqual(ResponseError.invalidURL.errorDescription, "Endpoint is not valid.")
        XCTAssertEqual(ResponseError.unexpectedStatusCode.errorDescription, "Unknown error occured.\nPlease try again.")
    }
}
