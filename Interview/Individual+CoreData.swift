//
//  Individual+CoreData.swift
//  Interview
//
//  Created by hhstuart on 7/19/22.
//

import Foundation

extension Individual {
	var fullName : String {
		var result : String = self.firstName ?? "<unknown>"
		if let lastName = self.lastName {
			if lastName.count != 0 {
				result = result + " " + lastName
			}
		}
		
		return result
	}
}
