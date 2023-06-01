//
//  TestUtilsTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import XCTest
@testable import CityWeather

final class TestUtilsTests: XCTestCase {

    func testIsUITest() {
        XCTAssertFalse(TestUtils.isUITest())
    }

    func testDataForRightResource() throws {
        XCTAssertNotNil(try TestUtils.data(forResource: "CityWeatherDataResponse"))
    }

    func testDataForWrongResource() throws {
        do {
            _ = try TestUtils.data(forResource: "WrongResource")
        } catch {
            XCTAssertNotNil(error)
        }
    }

}
