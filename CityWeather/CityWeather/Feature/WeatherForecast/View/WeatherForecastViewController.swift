//
//  WeatherForecastViewController.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

protocol WeatherForecastViewInterfaces: AnyObject {
    func showWeatherForecast(list: [DayForecast])
    func showErrorAlert(errorMessage: String)
}

class WeatherForecastViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private lazy var dataSource: WeatherForecastDataSource = {
        return WeatherForecastDataSource(cellIdentifier: String(describing: WeatherForecastCell.self), tableView: tableView)
    }()

    var interactor: WeatherForecastInteractorInterface?
    var router: WeatherForecastRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.searchWeatherForecastForCity()
    }

    private func setupView() {
        title = interactor?.getCityName()
        WeatherForecastCell.registerWithTable(tableView: tableView)
    }
}

extension WeatherForecastViewController: WeatherForecastViewInterfaces {
    func showWeatherForecast(list: [DayForecast]) {
        var snapShot = NSDiffableDataSourceSnapshot<WeatherForecastSection, DayForecast>()
        snapShot.appendSections(WeatherForecastSection.allCases)
        list.forEach { details in
            snapShot.appendItems([details], toSection: WeatherForecastSection.main)
        }
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
    
    func showErrorAlert(errorMessage: String) {
        
    }
}
