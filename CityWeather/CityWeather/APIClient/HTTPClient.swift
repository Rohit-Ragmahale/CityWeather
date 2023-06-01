//
//  HTTPClient.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol HTTPClientInterface {
    func load<T: Decodable>(networkRequest: NetworkRequest<T>, completion: @escaping (Result<T, ResponseError>) -> Void)
}

struct HTTPClient: HTTPClientInterface {
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

    func load<T: Decodable>(networkRequest: NetworkRequest<T>,
                            completion: @escaping (Result<T, ResponseError>) -> Void) {
        guard let request = networkRequest.request else {
            completion(.failure(.unknown))
            return
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, _ in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            switch response.statusCode {
            case 200...299:
                guard let data = data, let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.decode))
                    return
                }
                completion(.success(decodedResponse))
            default:
                completion(.failure(.unexpectedStatusCode))
            }
        }.resume()
    }
}
