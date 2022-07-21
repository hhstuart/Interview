//
//  InterviewApp.swift
//  Interview
//
//  Created by hhstuart on 7/18/22.
//

import SwiftUI

@main
struct InterviewApp: App {
	@StateObject private var dataController = DataController()
	
    var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
			}
		}
    }

