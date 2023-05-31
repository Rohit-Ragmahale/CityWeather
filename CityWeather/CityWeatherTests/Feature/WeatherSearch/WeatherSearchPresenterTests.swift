//
//  WeatherSearchPresenterTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

private class MockWeatherSearchRouter: WeatherSearchRouting {
    var showWeatherForcastExecuted = false
    func showWeatherForcast(city: String, cityId: String) {
        showWeatherForcastExecuted = true
    }
}

private class MockWeatherSearchViewController: WeatherSearchViewInterfaces {
    var showWeatherListExecuted = false
    var showErrorAlertExecuted = false

    func showWeatherList(list: [CityWeatherData]) {
        showWeatherListExecuted = true
    }

    func showErrorAlert(errorMessage: String) {
        showErrorAlertExecuted = true
    }
}

final class WeatherSearchPresenterTests: XCTestCase {
    var presenter: WeatherSearchPresenter?
    fileprivate var viewController: MockWeatherSearchViewController?
    fileprivate var router: MockWeatherSearchRouter?

    override func setUp() {
        super.setUp()
        // given
        viewController = MockWeatherSearchViewController()
        router = MockWeatherSearchRouter()

        presenter = WeatherSearchPresenter()
        presenter?.router = router
        presenter?.view = viewController
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
    }

    func testWeatherSearchPresenter_ShowForecastViewController() {
        // when
        presenter?.showWeatherForecastForCity(city: "leeds", cityId: "100")
        // then
        XCTAssertTrue(router?.showWeatherForcastExecuted ?? false)
    }

    func testWeatherSearchPresenter_ShowCityWeather() {
        // when
        presenter?.weatherListUpdated(list: [])
        // then
        XCTAssertTrue(viewController?.showWeatherListExecuted ?? false)
    }

    func testWeatherSearchPresenter_ShowErrorAlert() {
        // when
        presenter?.weatherRequestFailed(description: "Error")
        // then
        XCTAssertTrue(viewController?.showErrorAlertExecuted ?? false)
    }

}
