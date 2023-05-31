//
//  DateExtension.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import Foundation

extension Date {
    func getDateText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY, HH:MM"
        return dateFormatter.string(from: self)
    }
}
