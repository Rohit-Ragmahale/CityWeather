//
//  WeatherForecastCell.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import UIKit

final class WeatherForecastCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var temperatureDetails: UILabel!
    @IBOutlet private weak var humidityDetails: UILabel!

    // MARK: - View Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Theme.ForecastPage.cityWeatherForecastBGColor
    }

    // MARK: - View Setup method
    func inflateWith(forecast: DayForecast) {
        weatherImageView?.image = UIImage.getWeatherIcon(condition: forecast.imageID ?? 0)
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
