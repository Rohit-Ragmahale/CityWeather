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
        XCTAssertEqual(ResponseError.decode.errorDescription, "Response parsing failed")
        XCTAssertEqual(ResponseError.invalidURL.errorDescription, "Endpoint is not valid")
        XCTAssertEqual(ResponseError.noResponse.errorDescription, "City weather data not found")
        XCTAssertEqual(ResponseError.unexpectedStatusCode.errorDescription, "Unknown error\nPlease try again")
        XCTAssertEqual(ResponseError.unknown.errorDescription, "Unknown error\nPlease try again")
        XCTAssertEqual(ResponseError.unauthorized.errorDescription, "Unknown error\nPlease try again")
        XCTAssertEqual(ResponseError.decode.errorDescription, "Response parsing failed")
    }
}
