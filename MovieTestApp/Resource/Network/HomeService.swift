//
//  HomeService.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import Foundation
import Combine

public protocol BaseService {
    func request<T: Codable>(with endpoint: MovieEndpoint, expecting: T.Type) -> AnyPublisher<T, NetworkError>
}

public class HomeService: BaseService {
    
    public func request<T: Codable>(with endpoint: MovieEndpoint,
                           expecting: T.Type) -> AnyPublisher<T, NetworkError> {
        
        guard let url = URL(string: endpoint.urlString) else {
            return Fail<T, NetworkError>(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // Set up any request headers or parameters here
        endpoint.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        if let params = endpoint.params {
            var components = URLComponents(string: endpoint.urlString)
            var queryItems = [URLQueryItem]()
            _ = params.map {
                queryItems.append(URLQueryItem(name: $0, value: $1))
            }
            components?.queryItems = queryItems
            urlRequest.url = components?.url
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .tryMap { res in
                
                guard let response = res.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else {
                    let response = res.response as! HTTPURLResponse
                    throw NetworkError.invalidStatusCode(statusCode: response.statusCode)
                }
                
                return res.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // return error if json decoding fails
                NetworkError.failedToDecode
            }
            .eraseToAnyPublisher()
    }
}

public enum NetworkError: Error {
    case custom(error: Error)
    case failedToDecode
    case noData
    case invalidStatusCode(statusCode: Int)
    case invalidURL
    
    var description: String {
        switch self {
        case .custom(let error):
            return error.localizedDescription
        case .failedToDecode:
            return "Failed to decode json"
        case .noData:
            return "Data is not available"
        case .invalidStatusCode(let statusCode):
            return "Invalid status code: \(statusCode)"
        case .invalidURL:
            return "Invalid url"
        }
    }
}
