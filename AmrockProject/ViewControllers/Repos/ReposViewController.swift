//
//  ReposViewController.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import UIKit

enum TableViewState<T: Decodable> {
	case data(T)
	case message(String)
}

final class ReposViewController: UIViewController {

	private let networkManager: NetworkManager
	private var tableViewState: TableViewState<[Repo]> = TableViewState.message("") {
		didSet {
			switch tableViewState {
			case .data:
				tableView.isHidden = false
				messageLabel.isHidden = true
				tableView.reloadData()
			case .message(let message):
				tableView.isHidden = true
				messageLabel.isHidden = false
				messageLabel.text = message
			}
		}
	}

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.isHidden = true
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 100
		tableView.backgroundColor = .white
		tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
		tableView.dataSource = self
		tableView.delegate = self
		return tableView
	}()

	private let messageLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isHidden = true
		label.numberOfLines = 0
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = .lightGray
		label.textAlignment = .center
		return label
	}()

	private let activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView(style: .gray)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		return activityIndicator
	}()

	private lazy var fetchReposCompletion: (Result<[Repo], Error>) -> Void = { [weak self] result in
		guard let self = self else { return }
		DispatchQueue.main.async {
			self.activityIndicator.stopAnimating()
			switch result {
			case .success(let repos):
				self.tableViewState = .data(repos)
			case .failure(let error):
				self.tableViewState = .message(error.localizedDescription)
			}
		}
	}

	init(networkManager: NetworkManager) {
		self.networkManager = networkManager
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
		networkManager.request(RepoEndpoint.repo, completion: fetchReposCompletion)
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setToolbarHidden(true, animated: true)
	}

	func setupView() {
		navigationItem.title = "Repos"
		let logoutBarButtonItem = UIBarButtonItem(
			title: "Logout", style: .plain, target: self, action: #selector(logout))
		navigationItem.rightBarButtonItem = logoutBarButtonItem
		view.backgroundColor = .white

		view.addSubview(tableView)
		view.addSubview(messageLabel)
		view.addSubview(activityIndicator)
		activityIndicator.startAnimating()

		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			activityIndicator.widthAnchor.constraint(equalTo: view.widthAnchor),
			activityIndicator.heightAnchor.constraint(equalTo: view.heightAnchor)
		])

		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

		NSLayoutConstraint.activate([
			messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
		])
	}

	@objc private func logout() {
		dismiss(animated: true, completion: nil)
	}

}

extension ReposViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch tableViewState {
		case .data(let repos):
			return repos.count
		case .message:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard case .data(let repos) = tableViewState else { return UITableViewCell() }
		guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath)
				as? RepoCell else { return UITableViewCell() }
		let repo = repos[indexPath.row]
		let repoViewModel = RepoViewModel(repo: repo)
		cell.configure(with: repoViewModel)
		return cell
	}
}

extension ReposViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		guard case .data(let repos) = tableViewState else { return }
		let repo = repos[indexPath.item]
		let webViewController = WebViewController(title: repo.name, url: repo.htmlUrl)
		navigationController?.pushViewController(webViewController, animated: true)
	}
}
