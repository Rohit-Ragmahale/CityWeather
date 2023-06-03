//
//  HTTPClient.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation
import Combine

// MARK: - HTTPClient Interface
protocol HTTPClientInterface {
    @discardableResult
    func load<T: Decodable>(networkRequest: NetworkRequest<T>) -> AnyPublisher<T, ResponseError>
}

struct HTTPClient {
    // MARK: - Helper Method
    static func makeHTTPClient() -> HTTPClientInterface {
        #if MOCK_ENVIRONMENT
        MockHTTPClient()
        #else
        guard !TestUtils.isUITest() else {
            return MockHTTPClient()
        }
        return HTTPClient()
        #endif
    }
}

extension HTTPClient: HTTPClientInterface {
    func load<T: Decodable>(networkRequest: NetworkRequest<T>) -> AnyPublisher<T, ResponseError> {
        guard let request = networkRequest.request else {
            return Fail(error: ResponseError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .map {$0.data}
            .decode( type: T.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is URLError:
                    return ResponseError.invalidURL
                case is DecodingError:
                    return ResponseError.decode
                default:
                    return ResponseError.unexpectedStatusCode
                }
            }.eraseToAnyPublisher()
    }
}
