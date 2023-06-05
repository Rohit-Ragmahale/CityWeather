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

final class WeatherSearchViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var tableViewTopViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    // Variables
    private lazy var dataSource: WeatherListDataSource = {
        return WeatherListDataSource(cellIdentifier: String(describing: CityWeatherCell.self), tableView: tableView)
    }()
    private var shouldShowAddButton: Bool = false {
        didSet {
            navigationItem.rightBarButtonItem?.isHidden = !shouldShowAddButton
            searchButton.isHidden = shouldShowAddButton
            searchTextField.isHidden = shouldShowAddButton
        }
    }

    var interactor: WeatherSearchInteractorInterface?

    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - View Setup method
    private func setupView() {
        title = WeatherApp.searchWeatherTitle.localized

        // View set up
        CityWeatherCell.registerWithTable(tableView: tableView)
        setupSearchTextField()
        configureAddButton()

        // apply Theme
        setViewTheme()

        // Show search
        shouldShowAddButton = false
    }

    private func setupSearchTextField() {
        // Set up 'searchTextField'
        searchTextField.placeholder = WeatherApp.searchWeatherEnterCity.localized
        searchButton.setTitle(WeatherApp.searchWeatherSearchTitle.localized, for: .normal)
    }

    private func configureAddButton() {
        // Add 'rightBarButtonItem' to show serch text field
        let addButton = UIBarButtonItem(systemItem: .add,
                                        primaryAction: UIAction(handler: { [weak self] _ in
            self?.toggleSearchView(shouldShowSearchView: true)
            self?.searchTextField.becomeFirstResponder()
        }))

        navigationItem.rightBarButtonItem = addButton
    }

    // Set Theme
    private func setViewTheme() {
        // Apply Application color theme
        view.backgroundColor = Theme.HomePage.viewBGColor
        tableView.backgroundColor = Theme.HomePage.listBGColor
        searchButton.tintColor = Theme.HomePage.buttonTintColor
        searchTextField.textColor = Theme.HomePage.searchTextColor
        navigationItem.rightBarButtonItem?.tintColor = Theme.HomePage.buttonTintColor
    }

    private func toggleSearchView(shouldShowSearchView: Bool = false) {
        view.removeConstraint(tableViewTopViewConstraint)
        tableViewTopViewConstraint =  shouldShowSearchView ?
        tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: .spacing1) :
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        tableViewTopViewConstraint.isActive = true
        shouldShowAddButton = !shouldShowSearchView
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

    @IBAction private func searchCityButtonTapped(_ sender: Any) {
        guard let text = searchTextField.text else { return }
        interactor?.searchWeatherForCity(city: text)
        toggleSearchView()
        updateViewState(isSearching: true)
    }

    private func updateViewState(isSearching: Bool) {
        view.endEditing(true)
        navigationItem.rightBarButtonItem?.isEnabled = !isSearching
        if isSearching {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
}

// MARK: - UITableViewDelegate methods
extension WeatherSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.showWeatherForecastForCityAt(index: indexPath.row)
    }
}

// MARK: - WeatherSearchViewInterfaces methods
extension WeatherSearchViewController: WeatherSearchViewInterfaces {
    func showWeatherList(list: [CityWeatherData]) {
        var snapShot = NSDiffableDataSourceSnapshot<WeatherSection, CityWeatherData>()
        snapShot.appendSections(WeatherSection.allCases)
        list.forEach { snapShot.appendItems([$0], toSection: WeatherSection.main) }
        dataSource.apply(snapShot, animatingDifferences: true)
        searchTextField.text = nil
        updateViewState(isSearching: false)
    }

    func showErrorAlert(errorMessage: String) {
        updateViewState(isSearching: false)
        let dialog = UIAlertController(title: WeatherApp.error.localized, message: errorMessage, preferredStyle: .alert)
        let action: ((UIAlertAction) -> Void)? = { [weak self] _ in
            self?.toggleSearchView(shouldShowSearchView: true)
            self?.searchTextField.becomeFirstResponder()
        }
        dialog.addAction(UIAlertAction(title: WeatherApp.okTitle.localized, style: .cancel, handler: action))
        present(dialog, animated: true, completion: nil)
    }
}
