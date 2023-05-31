//
//  WeatherSearchInteractorTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

private class MockWeatherSearchPresenter: WeatherSearchPresenterInterface {
    var weatherListUpdatedExecuted = false
    var weatherRequestFailedExecuted = false
    var showWeatherForecastForCityExecuted = false
    func weatherListUpdated(list: [CityWeatherData]) {
        weatherListUpdatedExecuted = true
    }

    func weatherRequestFailed(description: String) {
        weatherRequestFailedExecuted = true
    }

    func showWeatherForecastForCity(city: String, cityId: String) {
        showWeatherForecastForCityExecuted = true
    }
}

final class WeatherSearchInteractorTests: XCTestCase {
    var service: WeatherService?
    fileprivate var presenter: MockWeatherSearchPresenter?
    var interactor: WeatherSearchInteractor?

    override func setUp() {
        super.setUp()
        // given
        service = WeatherService(httpsClient: MockHTTPClient())
        presenter = MockWeatherSearchPresenter()

        interactor = WeatherSearchInteractor()
        interactor?.presenter = presenter
        interactor?.service = service
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
    }

    func testWeatherSearchInteractor_SearchSuccess() {
        // when
        interactor?.searchWeatherForCity(city: "Leeds")
        // then
        let expectation =  expectation(description: "\(#function)-WeatherSearchInteractor Success")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            // then
            XCTAssertTrue(self.presenter?.weatherListUpdatedExecuted ?? false)

            // when
            self.interactor?.showWeatherForecastForCityAt(index: 0)
            // then
            XCTAssertTrue(self.presenter?.showWeatherForecastForCityExecuted ?? false)
        }

        wait(for: [expectation], timeout: 0.5)
    }

}
