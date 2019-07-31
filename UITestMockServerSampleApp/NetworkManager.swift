//
//  NetworkManager.swift
//  GCDWebServer
//
//  Created by Shayoke Mukherjee on 12/07/2019.
//

import Foundation

private let serverBaseURL = "jsonplaceholder.typicode.com"

public class NetworkManager {
    static let shared = NetworkManager()
    private lazy var decoder = JSONDecoder()
    
    private func buildURLRequest(from path: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.port = nil
        components.host = serverBaseURL
        components.path = path
        
        guard let url = components.url else {
            assertionFailure("unable to build URL")
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    private func callNetwork<T: Decodable>(session: URLSession = .shared,
                                   path: String,
                                   result: @escaping (Result<T, Error>) -> Void) {
        
        guard let request = buildURLRequest(from: path) else {
            result(.failure(NetworkError.badPath))
            return
        }
        
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                result(.failure(error))
                return
            }

            guard let data = data else {
                result(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try self.decoder.decode(T.self, from: data)
                result(.success(decodedResponse))
            } catch let error as DecodingError {
                result(.failure(NetworkError.decodingError(error)))
            } catch {
                result(.failure(NetworkError.decodingError(nil)))
            }
        }

        task.resume()
    }
}

public extension NetworkManager {
    func fetchPosts(result: @escaping (Result<[Post], Error>) -> Void) {
        callNetwork(path: "/posts/", result: result)
    }
}

enum NetworkError: Error {
    case badPath
    case noData
    case decodingError(DecodingError?)
}
