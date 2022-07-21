//
//  InitializeData.swift
//  Interview
//
//  Created by hhstuart on 7/18/22.
//

import Foundation
import CoreData
import UIKit
/**
 Resize image, maintaining the same aspect ratio
 
 - Parameter original: the original UIImage
 - Parameter newWidth: the new width of the image. The height will
					   be calculated from the original bounds
 - Returns: a resized image
 */
func InitializeData(contentView: NSManagedObjectContext) throws {
	let result = try contentView.fetch(Individual.fetchRequest())
	
	// if we don't have any data, load it
	if result.count == 0 {
		// load the data and install it into the data store
		let url = URL(string: "https://edge.ldscdn.org/mobile/interview/directory")
		if let url = url {
			let data = try LoadData(url: url)
			
			if let data = data {
				// convert the JSON formatted text to binary data
				let jsonData = try LoadIndividualsJSON(data: data)
				
				let dg = DispatchGroup()
				let dq = DispatchQueue.global(qos: .userInitiated)
				
				// now install the data into our store
				for i in jsonData {
					let cdIndividual = Individual(context: contentView)
					cdIndividual.forceSensitive = i.forceSensitive
					cdIndividual.affiliation = i.affiliation
					cdIndividual.birthdate = i.birthdate
					
					// some of these huge images take forever to render.
					// rather than have the user wait around for an
					// eternity, render and convert the images in
					// parallel
					
					dg.enter()
					dq.async {
						do {
							cdIndividual.profilePicture = try ImageUtils.loadImage(url: i.profilePicture)
						} catch {
							cdIndividual.profilePicture = nil
						}
						dg.leave()
					}
					
					cdIndividual.id = Int64(i.id)
					cdIndividual.firstName = i.firstName
					cdIndividual.lastName = i.lastName
				}
				
				// wait for all of our conversions to finish
				dg.wait()
				
				// save it to the backing store
				try contentView.save()
			} else {
				throw "Unable to load data"
			}
		} else {
			throw "Unable to parse URL"
		}
	}
}
