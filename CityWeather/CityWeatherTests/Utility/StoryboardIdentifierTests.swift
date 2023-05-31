//
//  StoryboardIdentifierTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class StoryboardIdentifierTests: XCTestCase {
    func testStoryboardIdentifier() {
        XCTAssertEqual(StoryboardIdentifier.weatherSearch.storyboardName, "Main")
        XCTAssertEqual(StoryboardIdentifier.weatherForecast.storyboardName, "Main")
    }
}
