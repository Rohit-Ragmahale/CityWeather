//
//  WeatherForecastConfiguratorTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class WeatherForecastConfiguratorTests: XCTestCase {
    func testWeatherForecastConfigurator() {
        // given
        let service = WeatherForecastService(httpsClient: MockHTTPClient())
        let config = WeatherForecastConfigurator(service: service, city: "city", cityId: "100")

        // when
        let viewController = config.configureViewController()

        // then
        XCTAssertTrue(viewController.isKind(of: WeatherForecastViewController.self))
        if let viewController = viewController as? WeatherForecastViewController {
            XCTAssertNotNil(viewController.interactor)
        } else {
            XCTFail("WeatherForecastConfigurator should return WeatherForecastViewController")
        }
    }
}
