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
        let interactor = WeatherSearchInteractor()
        let presenter = WeatherSearchPresenter()

        // Router -> ViewController
        let router = WeatherSearchRouter(viewController: viewController)

        // ViewController -> Interactor
        viewController.interactor = interactor

        // Interactor -> Presenter
        interactor.presenter = presenter
        interactor.service = WeatherService(httpsClient: MockHTTPClient())

        // Presenter -> Router
        presenter.router = router
        // Presenter -> ViewController
        presenter.view = viewController

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
