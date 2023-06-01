//
//  WeatherSearchConfiguratorTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class WeatherSearchConfiguratorTests: XCTestCase {
    func testWeatherSearchConfigurato() {
        // given
        let service = WeatherService(httpsClient: MockHTTPClient())
        let configurator = WeatherSearchConfigurator(service: service)

        // when
        let viewController = configurator.configureViewController()

        // then
        XCTAssertTrue(viewController.isKind(of: WeatherSearchViewController.self))
//        if let viewController = viewController as? WeatherSearchViewController {
//            XCTAssertNotNil(viewController.interactor)
//        } else {
//            XCTFail("WeatherSearchConfigurator should return WeatherSearchViewController")
//        }
    }

}
