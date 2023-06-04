//
//  WeatherSearchViewControllerTests.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import XCTest
import iOSSnapshotTestCase
import iOSSnapshotTestCaseCore
@testable import CityWeather

final class WeatherSearchViewControllerTests: FBSnapshotTestCase {
    var viewController: WeatherSearchViewController!
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

    #if ENABLE_SNAPSHOT_TEST
    func testWeatherSearchViewWithResult() throws {
        // given
        loadViewController()
        viewController.loadViewIfNeeded()
        guard let weather = MockProvider.getCityWeatherData() else {
            XCTFail("Failed to generate mock")
            return
        }

        // when
        viewController.showWeatherList(list: [weather])

        // then
        let expectation =  expectation(description: "\(#function)-Weather`Forecast Leaded` Success")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
            self.FBSnapshotVerifyViewController(self.navigationController)
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testWeatherSearchViewWithNoResult() throws {
        // when
        loadViewController()

        // then
        let expectation =  expectation(description: "\(#function)-Weather`Forecast Leaded` Success")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
            self.FBSnapshotVerifyViewController(self.navigationController)
        }
        wait(for: [expectation], timeout: 0.5)
    }

    func testWeatherSearchViewWithError() throws {
        // given
        loadViewController()
        viewController.loadViewIfNeeded()

        // when
        viewController.showErrorAlert(errorMessage: "This is test message to test Alert")

        // then
        let expectation =  expectation(description: "\(#function)-Weather`Forecast Leaded` Success")
        // Wait for mock response and check result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
            self.FBSnapshotVerifyViewController(self.navigationController.presentedViewController!)
        }
        wait(for: [expectation], timeout: 0.5)
    }

    private func loadViewController() {
        let service = WeatherService(httpsClient: MockHTTPClient())
        let configurator = WeatherSearchConfigurator(service: service, dataStore: DataStore())
        guard let viewController = configurator.configureViewController() as? WeatherSearchViewController else {
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
