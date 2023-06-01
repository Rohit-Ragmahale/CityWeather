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
    override func setUp() {
        super.setUp()
//        recordMode = true
    }

    #if ENABLE_SNAPSHOT_TEST
    func testWeatherSearchConfigurator() throws {
        let service = WeatherService(httpsClient: MockHTTPClient())
        let configurator = WeatherSearchConfigurator(service: service, dataStore: DataStore())
        let viewController = configurator.configureViewController()

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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
            self.FBSnapshotVerifyViewController(navigationController)
        }
        wait(for: [expectation], timeout: 0.5)
    }
    #endif
}
