//
//  EndPointConstructable.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import Foundation

protocol EndpointConstructable {
	var path: String { get }
	var httpMethod: HTTPMethod { get }
}

extension EndpointConstructable {
	var baseURL: String {
		return "https://api.github.com/users/QuickenLoans"
	}
}
