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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = WeatherApp.searchWeatherTitle.localized
        searchTextField.placeholder = WeatherApp.searchWeatherEnterCity.localized
        searchButton.setTitle(WeatherApp.searchWeatherSearchTitle.localized, for: .normal)
        view.backgroundColor = Theme.HomePage.viewBGColor
        tableView.backgroundColor = Theme.HomePage.listBGColor
        searchButton.tintColor = Theme.HomePage.buttonTintColor
        searchTextField.textColor = Theme.HomePage.searchTextColor
        CityWeatherCell.registerWithTable(tableView: tableView)
        let action = UIAction(handler: { _ in
            self.toggleSearchView(shouldShowSearchView: true)
            self.searchTextField.becomeFirstResponder()
        })
        let button = UIBarButtonItem(systemItem: .add, primaryAction: action)
        button.tintColor = Theme.HomePage.buttonTintColor
        navigationItem.rightBarButtonItem = button

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
        interactor?.showWeatherForecastForCityAt(index: indexPath.row)
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
        let dialogMessage = UIAlertController(title: WeatherApp.error.localized,
                                              message: errorMessage, preferredStyle: .alert)
        let action: ((UIAlertAction) -> Void)? = { _ in
            self.toggleSearchView(shouldShowSearchView: true)
            self.searchTextField.becomeFirstResponder()
        }
        dialogMessage.addAction(UIAlertAction(title: WeatherApp.okTitle.localized, style: .cancel, handler: action))
        present(dialogMessage, animated: true, completion: nil)
    }
}
