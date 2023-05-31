//
//  SceneDelegate.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let viewController = WeatherSearchConfigurator(service: WeatherService()).configureViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

