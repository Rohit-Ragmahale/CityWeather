//
//  WeatherSearchView.swift
//  CityWeatherUITests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import XCTest

final class WeatherSearchView {
    var app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var enterCity: XCUIElement {
        app.textFields["cityTextField"]
    }

    var searchButton: XCUIElement {
        app.buttons["searchButton"]
    }

    var weatherList: XCUIElement {
        app.tables.firstMatch
    }

    var btnSettingsAdd: XCUIElement {
        app.navigationBars.firstMatch.buttons["Add"]
    }
}
