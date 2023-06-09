//
//  FutureForecasts.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

// MARK: - Weather Forecast API Response
struct FutureForecasts: Decodable {
    var list: [DayForecast] = []

    private enum ForecatsCodingKeys: String, CodingKey {
        case list
    }

    private enum DataCodingKeys: String, CodingKey {
        case id
        case date = "dt"
        case main
        case weather
    }

    private enum MainKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case pressure
    }

    // Application do not to parsed whole json body
    // Application only parsed attributes which are required to render on UI as per business requirements.
    init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: ForecatsCodingKeys.self) {

            if var forecastArray = try? container.nestedUnkeyedContainer(forKey: ForecatsCodingKeys.list) {
                var forecasts = [DayForecast]()

                while !forecastArray.isAtEnd {

                    if let item = try? forecastArray.nestedContainer(keyedBy: DataCodingKeys.self) {

                        var forecast = DayForecast()

                        if let timeInterval = try item.decodeIfPresent(TimeInterval.self, forKey: .date) {
                            forecast.date = Date(timeIntervalSince1970: timeInterval)
                        }

                        if let weatherList: [Weather] = try? item.decodeIfPresent([Weather].self, forKey: .weather),
                            let weather = weatherList.first {
                            forecast.weatherDescription = weather.description
                            forecast.imageID = weather.id

                        }

                        if let mainContainer = try? item.nestedContainer(keyedBy: MainKeys.self, forKey: .main) {
                            forecast.temperature = try mainContainer.decodeIfPresent(Double.self, forKey: .temperature)
                            forecast.humidity = try mainContainer.decodeIfPresent(Double.self, forKey: .humidity)
                            forecast.pressure = try mainContainer.decodeIfPresent(Double.self, forKey: .pressure)
                        }
                        forecasts.append(forecast)
                    }
                }
                list = forecasts
            }
        }
    }
}
