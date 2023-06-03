//
//  ImageExtension.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 02/06/2023.
//

import UIKit

// MARK: - Weather Condition
private enum Condition: String {
    case clear
    case clouds
    case fog
    case lightRain
    case rain
    case snow
    case storm
}

extension UIImage {
    // MARK: - Weather Condition Icon
    static func getWeatherIcon(condition: Int) -> UIImage? {
        switch condition {
        case  200...232:
            return UIImage(named: Condition.storm.rawValue)
        case 501...511:
            return UIImage(named: Condition.rain.rawValue)
        case 500:
            return UIImage(named: Condition.lightRain.rawValue)
        case 520...531:
            return UIImage(named: Condition.lightRain.rawValue)
        case 600...622:
            return UIImage(named: Condition.snow.rawValue)
        case 801...804:
            return UIImage(named: Condition.clouds.rawValue)
        case 741...761:
            return UIImage(named: Condition.fog.rawValue)
        default:
            return UIImage(named: Condition.clear.rawValue)
        }
    }
}
