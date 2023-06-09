//
//  WeatherListDataSource.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit
// MARK: - UITableView Section
enum WeatherSection: Hashable, CaseIterable {
    case main
}

// MARK: - UITableViewDiffableDataSource Implementation
final class WeatherListDataSource: UITableViewDiffableDataSource<WeatherSection, CityWeatherData> {
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, _, weatherData in
            let cellIdentifier = String(describing: CityWeatherCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            guard let cell: CityWeatherCell = cell as? CityWeatherCell else { return UITableViewCell() }
            cell.inflateWith(weather: weatherData)
            return cell
        }
    }
}
