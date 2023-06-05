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
    func showWeatherForcast(city: String, cityId: String, dataStore: DataProvider) {
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
    fileprivate var router: MockWeatherSearchRouter!

    override func setUp() {
        super.setUp()
        // given
        viewController = MockWeatherSearchViewController()
        router = MockWeatherSearchRouter()

        presenter = WeatherSearchPresenter(view: viewController, router: router)
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
    }

    func testWeatherSearchPresenter_ShowForecastViewController() {
        // when
        presenter?.showWeatherForecastForCity(city: "leeds", cityId: "100", dataStore: DataStore())
        // then
        let expectation =  expectation(description: "\(#function)-test_ShowForecastViewController")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            XCTAssertTrue(self.router?.showWeatherForcastExecuted ?? false)
        }
        wait(for: [expectation], timeout: 0.2)
    }

    func testWeatherSearchPresenter_ShowCityWeather() {
        // when
        presenter?.weatherListUpdated(list: [])
        // then
        let expectation =  expectation(description: "\(#function)-testWeatherSearchPresenter_ShowCityWeather")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            XCTAssertTrue(self.viewController?.showWeatherListExecuted ?? false)
        }
        wait(for: [expectation], timeout: 0.2)
    }

    func testWeatherSearchPresenter_ShowErrorAlert() {
        // when
        presenter?.weatherRequestFailed(description: "Error")
        // then
        let expectation =  expectation(description: "\(#function)-testWeatherSearchPresenter_ShowErrorAlert")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            XCTAssertTrue(self.viewController?.showErrorAlertExecuted ?? false)
        }
        wait(for: [expectation], timeout: 0.2)
    }

}
