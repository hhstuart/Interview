//
//  DataController.swift
//  Interview
//
//  Created by hhstuart on 7/18/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
	let container = NSPersistentContainer(name: "Interview")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Core Data failed to load: \(error.localizedDescription)")
				exit(1)
			}
		}
	}
}

