//
//  CityWeatherUITests.swift
//  CityWeatherUITests
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import XCTest

final class CityWeatherUITests: XCTestCase {
    private var app: XCUIApplication!
    private var contentViewPage: WeatherSearchView!
    var timer: WaitTimer!

    override func setUp() {
        app = XCUIApplication()
        app.launchEnvironment["isUITest"] = "1"
        contentViewPage = WeatherSearchView(app: app)
        continueAfterFailure = false
        timer = WaitTimer()
        app.launch()
    }

    func testSearchWeatherForCityScenario() {
        contentViewPage.enterCity.tap()
        contentViewPage.enterCity.typeText("Leeds")
        contentViewPage.searchButton.tap()
        timer.wait(for: 0.5)
        contentViewPage.weatherList.cells.firstMatch.tap()
    }

    func testSearchWeatherForCityScenarioAddAnotherCity() {
        contentViewPage.enterCity.tap()
        contentViewPage.enterCity.typeText("Leeds")
        contentViewPage.searchButton.tap()
        timer.wait(for: 0.5)
        contentViewPage.btnSettingsAdd.tap()
        contentViewPage.enterCity.tap()
        contentViewPage.enterCity.typeText("London")
        contentViewPage.searchButton.tap()
        timer.wait(for: 1.0)
    }
}
