//
//  WeatherSearchRouterTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import XCTest
@testable import CityWeather

final class WeatherSearchRouterTests: XCTestCase {
    func testWeatherSearchRouter() {
        let viewController: WeatherSearchViewController = UIStoryboard.instantiate(identifier: .weatherSearch)

        // Router -> ViewController
        let router = WeatherSearchRouter(viewController: viewController)

        // Presenter -> ViewController
        // Presenter -> Router
        let presenter = WeatherSearchPresenter(view: viewController, router: router)

        let service = WeatherService(httpsClient: MockHTTPClient())
        // Interactor -> Presenter
        let interactor = WeatherSearchInteractor(service: service, presenter: presenter)

        // ViewController -> Interactor
        viewController.interactor = interactor

        let navigationController = UINavigationController(rootViewController: viewController)

        router.showWeatherForcast(city: "Leeds", cityId: "100")

        let expectation =  expectation(description: "\(#function)-ForcastVC Pushed Expectation")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // then
            expectation.fulfill()
            let topVC = navigationController.topViewController
            XCTAssertTrue(topVC?.isKind(of: WeatherForecastViewController.self) ?? false)
        }

        wait(for: [expectation], timeout: 0.5)
    }
}
