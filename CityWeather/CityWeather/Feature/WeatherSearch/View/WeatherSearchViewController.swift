//
//  WeatherSearchViewController.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import UIKit

protocol WeatherSearchViewInterfaces: AnyObject {
    func showWeatherList(list: [CityWeatherData])
    func showErrorAlert(errorMessage: String)
}

class WeatherSearchViewController: UIViewController {
    
    @IBOutlet weak var tableViewSuperViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    private lazy var dataSource: WeatherListDataSource = {
        return WeatherListDataSource(cellIdentifier: "cellIdentifier", tableView: tableView)
    }()

    var interactor: WeatherSearchInteractorInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = "City Weather"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        let button = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { action in
            self.toggleSearchView()
        }))
        self.navigationItem.rightBarButtonItem = button
    }
 
    private func toggleSearchView() {
        tableViewSuperViewConstraint.isActive = !tableViewSuperViewConstraint.isActive
        tableViewStackViewConstraint.isActive = !tableViewStackViewConstraint.isActive
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func searchCityButtonTapped(_ sender: Any) {
        if let text = searchTextField.text {
            interactor?.searchWeatherForCity(city: text)
            toggleSearchView()
        }
    }
}

extension WeatherSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            self.searchTextField.text = nil
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }

    func showErrorAlert(errorMessage: String) {
        let dialogMessage = UIAlertController(title: "Oops!", message: errorMessage, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(dialogMessage, animated: true, completion: {
            self.toggleSearchView()
        })
    }
}
