//
//  NetworkManager.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import Foundation

enum NetworkError: String, Error {
	case urlDoesNotExist = "URL does not exist."
	case unknown
}

final class NetworkManager {
	private let session: URLSession

	init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	func request<T: Decodable>(_ endpoint: EndpointConstructable, completion: @escaping (Result<T, Error>) -> Void) {
		guard let url = URL(string: endpoint.baseURL)?.appendingPathComponent(endpoint.path) else {
			completion(.failure(NetworkError.urlDoesNotExist))
			return
		}

		var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
		request.httpMethod = endpoint.httpMethod.rawValue

		session.dataTask(with: request) { (data, _, error) in
			if let error = error {
				completion(.failure(error))
				return
			}

			if let data = data {
				do {
					let model = try JSONDecoder().decode(T.self, from: data)
					completion(.success(model))
				} catch let error {
					completion(.failure(error))
				}
			} else {
				completion(.failure(NetworkError.unknown))
			}
		}.resume()
	}
}
