//
//  DateExtension.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import Foundation

private let dataFormat = "dd/MM/YYYY, HH:MM"

extension Date {
    func getDateText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dataFormat
        return dateFormatter.string(from: self)
    }
}
