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
    @IBOutlet weak var tableViewTopViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    private lazy var dataSource: WeatherListDataSource = {
        return WeatherListDataSource(cellIdentifier: String(describing: CityWeatherCell.self), tableView: tableView)
    }()

    var interactor: WeatherSearchInteractorInterface?
    var router: WeatherSearchRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = "City Weather"
        searchTextField.placeholder = "Enter City"
        CityWeatherCell.registerWithTable(tableView: tableView)
        let button = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { action in
            self.toggleSearchView(shouldShowSearchView: true)
            self.searchTextField.becomeFirstResponder()
        }))
        self.navigationItem.rightBarButtonItem = button
    }
 
    private func toggleSearchView(shouldShowSearchView: Bool = false) {
        view.removeConstraint(tableViewTopViewConstraint)
        tableViewTopViewConstraint =  shouldShowSearchView ?
        tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: .spacing1) :
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        tableViewTopViewConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func searchCityButtonTapped(_ sender: Any) {
        view.endEditing(true)
        if let text = searchTextField.text {
            interactor?.searchWeatherForCity(city: text)
            toggleSearchView()
        }
    }
}

extension WeatherSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityCode = "\(interactor?.cityCodeforCity(index: indexPath.row) ?? 0)"
        let city = interactor?.cityName(index: indexPath.row) ?? ""
        router?.showWeatherForcast(city: city, cityCode: cityCode)
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
        dialogMessage.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            self.toggleSearchView(shouldShowSearchView: true)
            self.searchTextField.becomeFirstResponder()
        }))
        present(dialogMessage, animated: true, completion: nil)
    }
}
