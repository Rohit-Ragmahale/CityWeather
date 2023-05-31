//
//  HTTPClient.swift
//  CityWeather
//
//  Created by Rohit Ragmahale on 30/05/2023.
//

import Foundation

protocol HTTPClientInterface {
    func load<T>(networkRequest: NetworkRequest<T>, completion: @escaping (Result<T, ResponseError>) -> Void) where T : Decodable
}

struct HTTPClient: HTTPClientInterface {
    static func makeHTTPClient() -> HTTPClient {
        HTTPClient()
    }

    func load<T>(networkRequest: NetworkRequest<T>, completion: @escaping (Result<T, ResponseError>) -> Void) where T : Decodable {
        
        guard let request = networkRequest.request else {
            completion(.failure(.unknown))
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion( .failure(.noResponse))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let data = data, let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.decode))
                    return
                }
                completion( .success(decodedResponse))
            default:
                completion( .failure(.unexpectedStatusCode))
            }
            
        }.resume()
        
    }
}


