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
    var viewController: WeatherForecastViewController!
    var navigationController: UINavigationController!
    var sceneDelegate: SceneDelegate!
    override func setUp() {
        super.setUp()
        #if ENABLE_SNAPSHOT_TEST
//         recordMode = true
        #endif
    }

    override func tearDown() {
        viewController = nil
        navigationController = nil
        sceneDelegate = nil
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
        loadViewController()

        // then
        let expectation =  expectation(description: "\(#function)-Weather`Forecast Leaded` Success")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            expectation.fulfill()
            self.FBSnapshotVerifyViewController(self.navigationController)
        }
        wait(for: [expectation], timeout: 1.0)
    }

    private func loadViewController() {
        let service = WeatherForecastService(httpsClient: MockHTTPClient())
        let configurator = WeatherForecastConfigurator(service: service,
                                                       city: "Leeds",
                                                       cityId: "100",
                                                       dataStore: DataStore())

        guard let viewController = configurator.configureViewController() as? WeatherForecastViewController else {
            XCTFail("failed to load WeatherSearchViewController")
            return
        }

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        self.viewController = viewController
        self.sceneDelegate = sceneDelegate
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = Theme.navigationTintColor

        // Attach to window to loadView
        self.sceneDelegate.window?.rootViewController = navigationController
    }
    #endif
}
