//
//  DayForecast.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

struct DayForecast: Hashable {
    var date: Date?
    var temperature: Double?
    var humidity: Double?
    var pressure: Double?
    var imageID: Int?
    var weatherDescription: String?
}
