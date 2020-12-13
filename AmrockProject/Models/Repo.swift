//
//  Repo.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import Foundation

struct Repo: Decodable {
	let id: Int
	let name: String
	let description: String?
	let updatedAt: Date
	let htmlUrl: URL

	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case description
		case updatedAt = "updated_at"
		case htmlUrl = "html_url"
	}
}
