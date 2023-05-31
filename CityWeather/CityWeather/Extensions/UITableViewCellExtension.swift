//
//  UITableViewCellExtension.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import UIKit

extension UITableViewCell {
    static func registerWithTable(tableView: UITableView) {
        let nibName = String(describing: Self.self)
        let nib = UINib(nibName: nibName, bundle: Bundle(for: Self.self))
        tableView.register(nib, forCellReuseIdentifier: nibName)
    }
}
