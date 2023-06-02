//
//  WeatherForecastInteractorTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

private class MockWeatherForecastPresenter: WeatherForecastPresenterInterface {
    var showErrorAlertExecuted: Bool = false
    var showWeatherForecastExecuted: Bool = false

    func weatherForecatsListUpdated(list: [DayForecast]) {
        showWeatherForecastExecuted = true
    }
    func weatherForecastRequestFailed(description: String) {
        showErrorAlertExecuted = true
    }
}

final class WeatherForecastInteractorTests: XCTestCase {

    func testWeatherForecastInteractor() {
        // given
        let service = WeatherForecastService(httpsClient: MockHTTPClient())
        let presenter = MockWeatherForecastPresenter()
        let interactor = WeatherForecastInteractor(presenter: presenter,
                                                   cityId: "100",
                                                   city: "City",
                                                   service: service,
                                                   dataStore: DataStore())
        // when
        let city = interactor.currentCity

        // then
        XCTAssertEqual(city, "City")

        // when
        interactor.searchWeatherForecastForCity()
        let expectation =  expectation(description: "\(#function)-ShowWeatherForecastExecuted Expectation")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // then
            expectation.fulfill()
            XCTAssertTrue(presenter.showWeatherForecastExecuted)
        }

        wait(for: [expectation], timeout: 0.5)
    }

}
