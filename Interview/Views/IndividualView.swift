//
//  IndividualView.swift
//  Interview
//
//  Created by hhstuart on 7/19/22.
//

import SwiftUI

// make a lookup table of non-geek versions of the affiliation tag
let affiliationLookup = [
	"JEDI" : "Jedi",
	"RESISTANCE" : "Resistance",
	"FIRST_ORDER" : "First Order",
	"SITH" : "Sith"
]

let nameLabel = "Name"
let birthdateLabel = "Birthdate"
let forceLabel = "Force Sensitive"
let affiliation = "Affiliation"

let yes = "Yes"
let no = "No"

struct IndividualView: View {
	var individual : Individual
    var body: some View {
		VStack {
			Text(individual.fullName)
				.font(.headline)
				.bold()
			if let picture = individual.profilePicture {
				let image = try? ImageUtils.makeImage(data: picture)
				if let image = image {
					// we want to keep a consistent height here, so
					// calculate the new frame accordingly
					let resizedImage = ImageUtils.resizeImage(original: image, newWidth: 200, newHeight: 200)
					if let resizedImage = resizedImage {
						Image(uiImage: resizedImage)
					}
				}
			}
			HStack {
				if let date = individual.birthdate {
					Text("\(birthdateLabel):")
						.bold()
					let displayString = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
					Text("\(displayString)")
					Spacer()
				}
			}
			HStack {
				Text("\(forceLabel):")
					.bold()
				Text("\(individual.forceSensitive ? yes : no)")
				Spacer()
			}
			HStack {
				Text("\(affiliation):")
					.bold()
				Text(affiliationLookup[individual.affiliation!]!)
				Spacer()
			}
			Spacer()
		}
    }
}

// TODO: make the preview work here

