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

class WeatherForecastViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    // Variables
    private lazy var dataSource: WeatherForecastDataSource = {
        return WeatherForecastDataSource(cellIdentifier: String(describing: WeatherForecastCell.self),
                                         tableView: tableView)
    }()

    var interactor: WeatherForecastInteractorInterface?

    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.searchWeatherForecastForCity()
    }

    // MARK: - View Setup method
    private func setupView() {
        view.backgroundColor = Theme.ForecastPage.viewBGColor
        tableView.backgroundColor = Theme.ForecastPage.listBGColor
        title = interactor?.currentCity
        WeatherForecastCell.registerWithTable(tableView: tableView)
        spinner.startAnimating()
    }
}

// MARK: - WeatherForecastView Interface Implementation
extension WeatherForecastViewController: WeatherForecastViewInterfaces {
    func showWeatherForecast(list: [DayForecast]) {
        var snapShot = NSDiffableDataSourceSnapshot<WeatherForecastSection, DayForecast>()
        snapShot.appendSections(WeatherForecastSection.allCases)
        list.forEach { details in
            snapShot.appendItems([details], toSection: WeatherForecastSection.main)
        }
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
