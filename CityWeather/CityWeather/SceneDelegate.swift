//
//  SceneDelegate.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let configurator = WeatherSearchConfigurator(service: WeatherService(httpsClient: HTTPClient.makeHTTPClient()))
        let viewController = configurator.configureViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = Theme.navigationTintColor
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
