//
//  UIStoryboardExtension.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

private class BundleLocator {}

extension UIStoryboard {
    static func instantiate<T: UIViewController>(identifier: StoryboardIdentifier) -> T! {
        let storyboard = UIStoryboard(name: identifier.storyboardName, bundle: Bundle(for: BundleLocator.self))
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as? T else {
            fatalError("ViewController: \(identifier.rawValue) is not of type: \(T.self)")
        }
        return viewController
    }
}
