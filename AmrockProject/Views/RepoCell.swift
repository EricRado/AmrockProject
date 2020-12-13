//
//  RepoCell.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import UIKit

final class RepoCell: UITableViewCell {

	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .body)
		return label
	}()

	private let dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .caption1)
		return label
	}()

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont.preferredFont(forTextStyle: .subheadline)
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI() {
		let stackView = UIStackView(arrangedSubviews: [nameLabel, dateLabel, descriptionLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .leading
		stackView.axis = .vertical
		stackView.spacing = 8

		contentView.addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
		])
	}

	func configure(with repoViewModel: RepoViewModel) {
		nameLabel.text = repoViewModel.name
		dateLabel.text = repoViewModel.updatedAtFormatted
		descriptionLabel.text = repoViewModel.description
	}

}
