//
//  RepoViewModel.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import Foundation

struct RepoViewModel {
	let name: String
	let updatedAtFormatted: String?
	let description: String

	init(repo: Repo) {
		self.name = repo.name
		updatedAtFormatted = repo.updatedAt.dateTimeFormattedString
		self.description = repo.description ?? "No description available."
	}
}
