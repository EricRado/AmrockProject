//
//  RepoEndpoint.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import Foundation

enum RepoEndpoint {
	case repo
}

extension RepoEndpoint: EndpointConstructable {
	var path: String {
		switch self {
		case .repo:
			return "/repos"
		}
	}

	var httpMethod: HTTPMethod {
		switch self {
		case .repo:
			return .get
		}
	}
}
