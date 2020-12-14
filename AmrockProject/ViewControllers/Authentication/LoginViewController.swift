//
//  LoginViewController.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/13/20.
//

import UIKit

final class LoginViewController: UIViewController {

	private lazy var loginButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Login", for: .normal)
		button.setTitleColor(.blue, for: .normal)
		button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
		return button
	}()

	private lazy var helpButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Help", for: .normal)
		button.setTitleColor(.green, for: .normal)
		button.addTarget(self, action: #selector(helpButtonTapped), for: .touchUpInside)
		return button
	}()

	private let emailTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Email"
		return textField
	}()

	private let passwordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Password"
		return textField
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }

	private func setupUI() {
		view.backgroundColor = .white
		view.addSubview(emailTextField)
		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
		view.addSubview(helpButton)

		NSLayoutConstraint.activate([
			emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
			emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 48)
		])

		NSLayoutConstraint.activate([
			passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
			passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16)
		])

		NSLayoutConstraint.activate([
			loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16)
		])

		NSLayoutConstraint.activate([
			helpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			helpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16)
		])
	}

	private func presentAlertController(title: String, message: String) {
		let alertController = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertController, animated: true, completion: nil)
	}

	private func validateEmail(email: String?) -> Bool {
		guard let email = email, !email.isEmpty else {
			return false
		}

		let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
		let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
		return emailPredicate.evaluate(with: email)
	}

	private func validatePassword(password: String?) -> Bool {
		guard let password = password, !password.isEmpty else {
			return false
		}

		let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d$@$!%*?&]{9,}"
		let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
		return passwordPredicate.evaluate(with: password)
	}

	@objc private func loginButtonTapped() {
		guard validateEmail(email: emailTextField.text) else {
			presentAlertController(title: "Error", message: "Invalid email, please try again.")
			return
		}

		guard validatePassword(password: passwordTextField.text) else {
			presentAlertController(title: "Error", message: "Invalid password, please try again.")
			return
		}

		let reposViewController = ReposViewController(networkManager: NetworkManager())
		let navigationController = UINavigationController(rootViewController: reposViewController)
		navigationController.modalPresentationStyle = .fullScreen
		present(navigationController, animated: true, completion: nil)
	}

	@objc private func helpButtonTapped() {
		let message = """
			Please enter a valid email and a password containing at least 1 uppercase letter, 1 lowercase letter,
			and 1 number.
		"""
		presentAlertController(title: "Help", message: message)
	}

}
