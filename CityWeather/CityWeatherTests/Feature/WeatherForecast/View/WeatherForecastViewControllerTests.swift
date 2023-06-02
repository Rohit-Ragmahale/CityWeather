//
//  WeatherForecastViewControllerTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import XCTest
import iOSSnapshotTestCase
import iOSSnapshotTestCaseCore
@testable import CityWeather

private final class MockWeatherForecastInteractor: WeatherForecastInteractorInterface {
    var searchWeatherForecastForCityExecutected: Bool = false
    func searchWeatherForecastForCity() {
        searchWeatherForecastForCityExecutected = true
    }

    var currentCity: String? {
        "CurrentCity"
    }
}

final class WeatherForecastViewControllerTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
//        recordMode = true
    }

    func testWeatherForecastViewControllerDataLoading() {
        // given
        let viewController: WeatherForecastViewController = UIStoryboard.instantiate(identifier: .weatherForecast)
        let interactor = MockWeatherForecastInteractor()
        viewController.interactor = interactor

        // when
        viewController.viewDidLoad()

        // then
        XCTAssertTrue(interactor.searchWeatherForecastForCityExecutected)

    }

    #if ENABLE_SNAPSHOT_TEST
    func testWeatherForecastViewController() throws {
        // given
        let service = WeatherForecastService(httpsClient: MockHTTPClient())
        let configurator = WeatherForecastConfigurator(service: service,
                                                       city: "Leeds",
                                                       cityId: "100",
                                                       dataStore: DataStore())
        let viewController = configurator.configureViewController()

        // when
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = Theme.navigationTintColor

        // Attach to window to loadView
        sceneDelegate.window?.rootViewController = navigationController

        // then
        let expectation =  expectation(description: "\(#function)-Weather`Forecast Leaded` Success")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            expectation.fulfill()
            self.FBSnapshotVerifyViewController(navigationController)
        }
        wait(for: [expectation], timeout: 1.0)
    }
    #endif
}
