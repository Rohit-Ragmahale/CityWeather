//
//  WeatherForecastDataSource.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import UIKit

enum WeatherForecastSection: Hashable, CaseIterable {
    case main
}

class WeatherForecastDataSource: UITableViewDiffableDataSource<WeatherForecastSection, DayForecast> {
    init(cellIdentifier: String, tableView: UITableView) {
        super.init(tableView: tableView) { tableView, _, dayForecast in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            guard let cell: WeatherForecastCell = cell as? WeatherForecastCell else { return UITableViewCell() }
            cell.inflateWith(forecast: dayForecast)
            return cell
        }
    }
}
