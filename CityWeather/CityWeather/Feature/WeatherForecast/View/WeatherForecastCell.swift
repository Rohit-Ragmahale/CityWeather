//
//  WeatherForecastCell.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import UIKit

class WeatherForecastCell: UITableViewCell {
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var temperatureDetails: UILabel!
    @IBOutlet private weak var humidityDetails: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Theme.ForecastPage.cityWeatherForecastBGColor
    }

    func inflateWith(forecast: DayForecast) {
        date.text = forecast.date?.getDateText() ?? ""
        weatherDescription.text = forecast.weatherDescription
        if let temperature = forecast.temperature {
            temperatureDetails.text = String(format: WeatherApp.temperatureDetails.localized, "\(temperature)")
        } else {
            temperatureDetails.text = WeatherApp.tempDataNotAvaialble.localized
        }
        if let humidity = forecast.humidity {
            humidityDetails.text = String(format: WeatherApp.humidityDetails.localized, "\(humidity)")
        } else {
            humidityDetails.text = WeatherApp.humidityDataNotAvaialble.localized
        }
    }
}
