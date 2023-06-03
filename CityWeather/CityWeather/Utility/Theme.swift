//
//  Theme.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import UIKit

// MARK: - Application Color Scheme
struct Theme {
    static let navigationTintColor = UIColor(red: 02/255, green: 02/255, blue: 02/255, alpha: 1.0)

    struct HomePage {
        static let viewBGColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
        static let listBGColor = UIColor(red: 225/255, green: 245/255, blue: 254/255, alpha: 1.0)
        static let cityWeatherBGColor = UIColor(red: 179/255, green: 229/255, blue: 252/255, alpha: 1.0)
        static let buttonTintColor = UIColor(red: 02/255, green: 02/255, blue: 02/255, alpha: 1.0)
        static let searchTextColor = UIColor(red: 02/255, green: 02/255, blue: 02/255, alpha: 1.0)
    }

    struct ForecastPage {
        static let viewBGColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
        static let listBGColor = UIColor(red: 225/255, green: 245/255, blue: 254/255, alpha: 1.0)
        static let cityWeatherForecastBGColor = UIColor(red: 179/255, green: 229/255, blue: 252/255, alpha: 1.0)
        static let buttonTintColor = UIColor(red: 02/255, green: 02/255, blue: 02/255, alpha: 1.0)
    }
}
