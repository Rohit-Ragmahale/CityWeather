//
//  CityWeatherCell.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

class CityWeatherCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var city: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var temperatureDetails: UILabel!
    @IBOutlet private weak var humidityDetails: UILabel!
    // MARK: - Properties
    private let lineBreak = "\n"

    // MARK: - View Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        isAccessibilityElement = true
        backgroundColor = Theme.HomePage.cityWeatherBGColor
        #if WEATHER_FORECAST_DETAILS
        accessoryType = .disclosureIndicator
        #else
        accessoryType = .none
        #endif
    }

    // MARK: - View Setup method
    func inflateWith(weather: CityWeatherData) {
        weatherImageView?.image = UIImage.getWeatherIcon(condition: weather.forecast.imageID ?? 0)
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
        accessibilityLabel = [city.text, weatherDescription.text,
                              temperatureDetails.text,
                              humidityDetails.text,
                              WeatherApp.tapToViewForecast.localized]
            .compactMap { $0 }
            .joined(separator: lineBreak)
    }
}
