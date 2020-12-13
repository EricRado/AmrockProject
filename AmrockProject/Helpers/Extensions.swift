//
//  Extensions.swift
//  AmrockProject
//
//  Created by Eric Rado on 12/12/20.
//

import UIKit

extension UITableViewCell {
	static var identifier: String { String(describing: self) }
}

extension Date {
	var dateTimeFormattedString: String? {
		let dateFormater = DateFormatter()
		dateFormater.dateFormat = "MM/dd/yyyy hh:mm a"
		return dateFormater.string(from: self)
	}
}
