//
//  CityWeatherCell.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

class CityWeatherCell: UITableViewCell {
    @IBOutlet private weak var city: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var temperatureDetails: UILabel!
    @IBOutlet private weak var humidityDetails: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Theme.HomePage.cityWeatherBGColor
    }

    func inflateWith(weather: CityWeatherData) {
        city.text = weather.name
        weatherDescription.text = weather.forecast.weatherDescription
        if let temperature = weather.forecast.temperature {
            temperatureDetails.text = String(format: WeatherApp.temperatureDetails.localized, "\(temperature)")
        } else {
            temperatureDetails.text = WeatherApp.tempDataNotAvaialble.localized
        }
        if let humidity = weather.forecast.humidity {
            humidityDetails.text = String(format: WeatherApp.humidityDetails.localized, "\(humidity)")
        } else {
            humidityDetails.text = WeatherApp.humidityDataNotAvaialble.localized
        }
    }
}
