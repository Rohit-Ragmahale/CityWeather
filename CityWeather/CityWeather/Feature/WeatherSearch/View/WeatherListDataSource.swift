//
//  WeatherListDataSource.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

enum WeatherSection: Hashable, CaseIterable {
    case main
}

class WeatherListDataSource: UITableViewDiffableDataSource<WeatherSection, CityWeatherData> {
    init(cellIdentifier: String, tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, weatherData in
            guard let cell: CityWeatherCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CityWeatherCell else {
                return UITableViewCell()
            }
            cell.inflateWith(weather: weatherData)
            return cell
        }
    }
}
