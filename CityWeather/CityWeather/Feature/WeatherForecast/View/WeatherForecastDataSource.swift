//
//  WeatherForecastDataSource.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import UIKit
// MARK: - UITableView Section
enum WeatherForecastSection: Hashable, CaseIterable {
    case main
}

// MARK: - UITableViewDiffableDataSource Implementation
final class WeatherForecastDataSource: UITableViewDiffableDataSource<WeatherForecastSection, DayForecast> {
     init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, _, dayForecast in
            let cellIdentifier = String(describing: WeatherForecastCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            guard let cell: WeatherForecastCell = cell as? WeatherForecastCell else { return UITableViewCell() }
            cell.inflateWith(forecast: dayForecast)
            return cell
        }
    }
}
