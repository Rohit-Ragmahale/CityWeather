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
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            cell?.textLabel?.text = itemIdentifier.name ?? "" + "-\(itemIdentifier.forecast.temperature!)"
            return cell
        }
    }
}
