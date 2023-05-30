//
//  FutureForecasts.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

struct FutureForecasts: Decodable {
    var list: [DayForecast] = []
    
    private enum ForecatsCodingKeys: String, CodingKey {
        case list
    }
    
    private enum DataCodingKeys: String, CodingKey {
        case id
        case dt
        case main
        case weather
    }
    
    private enum MainKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case pressure
    }
    
    init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: ForecatsCodingKeys.self)  {
            if var forecastArray = try? container.nestedUnkeyedContainer(forKey: ForecatsCodingKeys.list) {
                var forecasts = [DayForecast]()
                
                while(!forecastArray.isAtEnd) {
                    
                    if let item = try? forecastArray.nestedContainer(keyedBy: DataCodingKeys.self) {
                        
                        var forecast = DayForecast()
                        
                        let timeInterval = try item.decode(TimeInterval.self, forKey: .dt)
                        forecast.date = Date(timeIntervalSince1970: timeInterval)
                        
                        if let weatherList: [Weather] = try? item.decode([Weather].self, forKey: .weather), let weather = weatherList.first {
                            forecast.weatherDescription = weather.description
                            forecast.imageID = weather.id
                            
                        }
                        
                        if let mainContainer = try? item.nestedContainer(keyedBy: MainKeys.self, forKey: .main) {
                            forecast.temperature = try mainContainer.decode(Double.self, forKey: .temperature)
                            forecast.humidity = try mainContainer.decode(Double.self, forKey: .humidity)
                            forecast.pressure = try mainContainer.decode(Double.self, forKey: .pressure)
                        }
                        forecasts.append(forecast)
                    }
                    
                }
                list = forecasts
            }
        }
    }
}
