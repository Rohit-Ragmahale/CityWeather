//
//  NetworkRequestTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class NetworkRequestTests: XCTestCase {

    func testNetWorkRequestForWeather() {
        // when
        let networkRequest = NetworkRequest<CityWeatherData>.currentWeather(city: "Leeds")
        // then
        XCTAssertEqual(networkRequest.url, "https://api.openweathermap.org/data/2.5/weather")
        XCTAssertEqual(networkRequest.parameters.count, 3)
        let appid = networkRequest.parameters[WeatherAPIConstants.QueryParameters.appid] as? String
        XCTAssertEqual(appid, "7eaab9424f40d70b55d21a995bc1bd4c")
        let units = networkRequest.parameters[WeatherAPIConstants.QueryParameters.units] as? String
        XCTAssertEqual(units, "metric")
        let city = networkRequest.parameters[WeatherAPIConstants.QueryParameters.city] as? String
        XCTAssertEqual(city, "Leeds")
        let request = networkRequest.request
        XCTAssertNotNil(request)
    }

    func testNetWorkRequestForForecast() {
        // when
        let networkRequest = NetworkRequest<FutureForecasts>.forecastWeather(cityId: "100")
        // then
        XCTAssertEqual(networkRequest.url, "https://api.openweathermap.org/data/2.5/forecast")
        XCTAssertEqual(networkRequest.parameters.count, 3)
        let appid = networkRequest.parameters[WeatherAPIConstants.QueryParameters.appid] as? String
        XCTAssertEqual(appid, "7eaab9424f40d70b55d21a995bc1bd4c")
        let units = networkRequest.parameters[WeatherAPIConstants.QueryParameters.units] as? String
        XCTAssertEqual(units, "metric")
        let cityid = networkRequest.parameters[WeatherAPIConstants.QueryParameters.cityId] as? String
        XCTAssertEqual(cityid, "100")
        let request = networkRequest.request
        XCTAssertNotNil(request)
    }
}
