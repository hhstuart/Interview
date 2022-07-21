//
//  ContentView.swift
//  Interview
//
//  Created by hhstuart on 7/18/22.
//

import SwiftUI

struct ContentView: View {
	@FetchRequest(sortDescriptors: [
		SortDescriptor(\Individual.lastName, order: .forward),
		SortDescriptor(\Individual.firstName, order: .forward)
	]) var individuals: FetchedResults<Individual>
	@Environment(\.managedObjectContext) var moc
	@State private var alertActive = false
	@State private var errorMessage : String = ""
	
	/**
	 Loads the data from the REST server and installs it into CoreData
	 
	 - Throws: A string which describes the exception
	 */
	func loadData() throws {
		try InitializeData(contentView: moc)
	}
	
    var body: some View {
		NavigationView {
			List {
				ForEach(individuals) {individual in
					NavigationLink {
						IndividualView(individual: individual)
					} label: {
						IndividualRow(individual: individual)
					}
				}
			}
			.navigationBarTitle("Characters")
		}
		.padding()
		.onAppear {
			do {
				try loadData()
			} catch let e {
				errorMessage = e.localizedDescription
				alertActive = true
			}
		}
		.alert(String("Operation Complete"), isPresented: $alertActive) {
			Button("OK", role: .cancel) {
			}
		} message: {
			Text(errorMessage)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
