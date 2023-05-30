//
//  WeatherSearchViewController.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

protocol WeatherSearchViewInterfaces: AnyObject {
    func showWeatherList(list: [CityWeatherData])
    func showErrorAlert()
}

class WeatherSearchViewController: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    private lazy var dataSource: WeatherListDataSource = {
        return WeatherListDataSource(cellIdentifier: "cellIdentifier", tableView: tableView)
    }()

    var interactor: WeatherSearchInteractorInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "search city data"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }

    @IBAction func searchCityButtonTapped(_ sender: Any) {
        if let text = searchTextField.text {
            interactor?.searchWeatherForCity(city: text)
        }
    }
}

extension WeatherSearchViewController: WeatherSearchViewInterfaces {
    func showWeatherList(list: [CityWeatherData]) {
        var snapShot = NSDiffableDataSourceSnapshot<WeatherSection, CityWeatherData>()
        snapShot.appendSections(WeatherSection.allCases)
        list.forEach { details in
            snapShot.appendItems([details], toSection: WeatherSection.main)
        }
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
    
    func showErrorAlert() {
        
    }
}
