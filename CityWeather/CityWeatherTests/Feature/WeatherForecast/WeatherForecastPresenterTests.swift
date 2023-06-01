//
//  WeatherForecastPresenterTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

private class MockWeatherForecastViewController: WeatherForecastViewInterfaces {
    var showErrorAlertExecuted: Bool = false
    var showWeatherForecastExecuted: Bool = false
    func showWeatherForecast(list: [DayForecast]) {
        showWeatherForecastExecuted = true
    }

    func showErrorAlert(errorMessage: String) {
        showErrorAlertExecuted = true
    }
}

final class WeatherForecastPresenterTests: XCTestCase {
    func testWeatherForecastPresenter() {
        // given
        let view = MockWeatherForecastViewController()
        let router = WeatherForecastRouter(viewController: UIViewController())
        let presenter = WeatherForecastPresenter(view: view, router: router)

        // when
        presenter.weatherForecatsListUpdated(list: [])
        // then
        XCTAssertTrue(view.showWeatherForecastExecuted)

        // when
        presenter.weatherForecastRequestFailed(description: "Error")
        // then
        XCTAssertTrue(view.showErrorAlertExecuted)

    }
}
