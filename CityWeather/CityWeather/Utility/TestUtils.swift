//
//  TestUtils.swift
//  CityWeatherTests
//
//  Created by Rohit Ragmahale on 31/05/2023.
//

import Foundation

final class TestUtils {
    static func data(forResource resource: String, ext: String = "json") throws -> Data {
        let testBundle = Bundle(for: type(of: TestUtils().self))

        guard let url = testBundle.url(forResource: resource, withExtension: ext) else {
            throw NSError(domain: "TEST", code: 0,
                          userInfo: [NSLocalizedDescriptionKey: "No url  found for \(resource).\(ext)"])
        }
        return try Data(contentsOf: url)
    }

    static func isUITest() -> Bool {
        return ProcessInfo.processInfo.environment.keys.contains("isUITest")
    }
}
