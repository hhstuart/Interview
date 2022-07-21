//
//  IndividualRow.swift
//  Interview
//
//  Created by hhstuart on 7/19/22.
//

import SwiftUI

struct IndividualRow: View {
	var individual: Individual
	
    var body: some View {
		HStack {
			if let picture = individual.profilePicture {
				let image = try? ImageUtils.makeImage(data: picture)
				if let image = image {
					// we want to keep a consistent height here, so
					// calculate the new frame accordingly
					let resizedImage = ImageUtils.resizeImage(original: image, newWidth: 50, newHeight: 50)
					if let resizedImage = resizedImage {
						Image(uiImage: resizedImage)
					}
				}
			}
			Text(individual.fullName)
			Spacer()
		}
    }
}

// TODO: Figure out how to get the preview working
