//
//  ImageExtensionTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 03/06/2023.
//

import XCTest
@testable import CityWeather

final class ImageExtensionTests: XCTestCase {

    func testImageIcon_StormCondition() throws {
        let expectedData = try XCTUnwrap(UIImage(named: "storm")?.pngData())
        let actualData = try XCTUnwrap(UIImage.getWeatherIcon(condition: 200)?.pngData())
        XCTAssertEqual(expectedData, actualData)
    }

    func testImageIcon_RainCondition() throws {
        let expectedData = try XCTUnwrap(UIImage(named: "rain")?.pngData())
        let actualData = try XCTUnwrap(UIImage.getWeatherIcon(condition: 501)?.pngData())
        XCTAssertEqual(expectedData, actualData)
    }

    func testImageIcon_LightRain500Condition() throws {
        let expectedData = try XCTUnwrap(UIImage(named: "lightRain")?.pngData())
        let actualData = try XCTUnwrap(UIImage.getWeatherIcon(condition: 500)?.pngData())
        XCTAssertEqual(expectedData, actualData)
    }

    func testImageIcon_LightRainCondition() throws {
        let expectedData = try XCTUnwrap(UIImage(named: "lightRain")?.pngData())
        let actualData = try XCTUnwrap(UIImage.getWeatherIcon(condition: 520)?.pngData())
        XCTAssertEqual(expectedData, actualData)
    }

    func testImageIcon_SnowCondition() throws {
        let expectedData = try XCTUnwrap(UIImage(named: "snow")?.pngData())
        let actualData = try XCTUnwrap(UIImage.getWeatherIcon(condition: 600)?.pngData())
        XCTAssertEqual(expectedData, actualData)
    }

    func testImageIcon_CloudsCondition() throws {
        let expectedData = try XCTUnwrap(UIImage(named: "clouds")?.pngData())
        let actualData = try XCTUnwrap(UIImage.getWeatherIcon(condition: 801)?.pngData())
        XCTAssertEqual(expectedData, actualData)
    }

    func testImageIcon_FogCondition() throws {
        let expectedData = try XCTUnwrap(UIImage(named: "fog")?.pngData())
        let actualData = try XCTUnwrap(UIImage.getWeatherIcon(condition: 741)?.pngData())
        XCTAssertEqual(expectedData, actualData)
    }

    func testImageIcon_DefaultCondition() throws {
        let expectedData = try XCTUnwrap(UIImage(named: "clear")?.pngData())
        let actualData = try XCTUnwrap(UIImage.getWeatherIcon(condition: 0)?.pngData())
        XCTAssertEqual(expectedData, actualData)
    }
}
