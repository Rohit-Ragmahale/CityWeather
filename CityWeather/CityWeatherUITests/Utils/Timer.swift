//
//  Timer.swift
//  CityWeatherUITests
//
//  Created by Rohit Ragmahale on 01/06/2023.
//

import XCTest

class WaitTimer: XCTestCase {
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }

}
