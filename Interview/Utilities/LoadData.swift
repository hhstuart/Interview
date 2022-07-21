//
//  LoadData.swift
//  wookie
//
//  Created by hhstuart on 7/16/22.
//

import Foundation

func LoadData(url: URL) throws -> Data? {
	// make the response structure
	let data = try Data(contentsOf: url)
	return data
}
