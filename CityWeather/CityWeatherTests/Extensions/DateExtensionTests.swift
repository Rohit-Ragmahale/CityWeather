//
//  DateExtensionTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class DateExtensionTests: XCTestCase {

    func testGetDateText() {
        // given
        let date = Date.init(timeIntervalSince1970: 978307200)
        // then
        XCTAssertEqual(date.getDateText(), "01/01/2001, 00:01")
    }
}
