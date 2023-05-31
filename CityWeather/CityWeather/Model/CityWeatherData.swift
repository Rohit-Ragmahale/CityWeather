//
//  CityWeatherData.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

final class CityWeatherData: Decodable, Hashable {
    var name: String?
    var id: Int = 0
    var forecast: DayForecast = DayForecast()
   // var futureForecast: [DayForecast] = []

    private enum MainKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case pressure
    }

    private enum WeatherResponseCodingKeys: String, CodingKey {
        case name
        case id
        case dt
        case main
        case weather
    }

    required init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: WeatherResponseCodingKeys.self) {
            name = try container.decode(String.self, forKey: .name)
            id = try container.decode(Int.self, forKey: .id)

            forecast = DayForecast()

            let timeInterval = try container.decode(TimeInterval.self, forKey: .dt)
            forecast.date = Date(timeIntervalSince1970: timeInterval)

            if let weatherList: [Weather] = try? container.decode([Weather].self, forKey: .weather),
                let weather = weatherList.first {
                forecast.weatherDescription = weather.description
                forecast.imageID = weather.id

            }

            if let mainContainer = try? container.nestedContainer(keyedBy: MainKeys.self, forKey: .main) {
                forecast.temperature = try mainContainer.decode(Double.self, forKey: .temperature)
                forecast.humidity = try mainContainer.decode(Double.self, forKey: .humidity)
                forecast.pressure = try mainContainer.decode(Double.self, forKey: .pressure)
            }

        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    static func == (lhs: CityWeatherData, rhs: CityWeatherData) -> Bool {
        lhs.name == rhs.name
    }
}
