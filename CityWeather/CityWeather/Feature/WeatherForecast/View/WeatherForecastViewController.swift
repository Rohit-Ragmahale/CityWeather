//
//  WeatherForecastViewController.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

// MARK: - WeatherForecastView Interfaces
protocol WeatherForecastViewInterfaces: AnyObject {
    func showWeatherForecast(list: [DayForecast])
    func showErrorAlert(errorMessage: String)
}

final class WeatherForecastViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    // Variables
    private lazy var dataSource: WeatherForecastDataSource = {
        let cellIdentifier = String(describing: WeatherForecastCell.self)
        return WeatherForecastDataSource(cellIdentifier: cellIdentifier,
                                         tableView: tableView)
    }()

    var interactor: WeatherForecastInteractorInterface?

    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up UI
        setupView()
        // Request for forecast data
        interactor?.searchWeatherForecastForCity()
        spinner.startAnimating()
    }

    // MARK: - View Setup method
    private func setupView() {
        title = interactor?.currentCity
        // Apply App Color Theme
        view.backgroundColor = Theme.ForecastPage.viewBGColor
        tableView.backgroundColor = Theme.ForecastPage.listBGColor

        WeatherForecastCell.registerWithTable(tableView: tableView)
    }
}

// MARK: - WeatherForecastView Interface Implementation
extension WeatherForecastViewController: WeatherForecastViewInterfaces {
    func showWeatherForecast(list: [DayForecast]) {
        var snapShot = NSDiffableDataSourceSnapshot<WeatherForecastSection, DayForecast>()
        snapShot.appendSections(WeatherForecastSection.allCases)
        snapShot.appendItems(list, toSection: WeatherForecastSection.main)
        spinner.stopAnimating()
        dataSource.apply(snapShot, animatingDifferences: true)
    }

    func showErrorAlert(errorMessage: String) {
        spinner.stopAnimating()
        let dialog = UIAlertController(title: WeatherApp.error.localized, message: errorMessage, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: WeatherApp.okTitle.localized, style: .cancel))
        present(dialog, animated: true, completion: nil)
    }
}
