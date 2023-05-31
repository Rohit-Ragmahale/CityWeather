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
            temperatureDetails.text = String(format: WeatherApp.temperature_details.localized, "\(temperature)")
        } else {
            temperatureDetails.text = WeatherApp.temp_data_not_avaialble.localized
        }
        if let humidity = weather.forecast.humidity {
            humidityDetails.text = String(format: WeatherApp.temperature_details.localized, "\(humidity)")
        } else {
            humidityDetails.text = WeatherApp.humidity_data_not_avaialble.localized
        }
    }
}
