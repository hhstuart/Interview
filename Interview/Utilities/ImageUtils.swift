//
//  ImageUtils.swift
//  Interview
//
//  Created by hhstuart on 7/19/22.
//

import Foundation
import UIKit

class ImageUtils {
	static func resizeImage(original: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
		let newSize = CGSize(width: newWidth, height: newHeight)
		UIGraphicsBeginImageContext(newSize)
		let newRect = CGRect(origin: CGPoint(x : 0, y : 0), size: newSize)
		original.draw(in: newRect)
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		return resizedImage
	}

	static func loadImage(url: URL) throws -> Data? {
		// get the data
		let data = try Data(contentsOf: url)
		
		// make an image out of it
		let loadedImage = UIImage(data: data)
		if let loadedImage = loadedImage {
			// Some of these images are HUGE! We will
			// need to rescale them to something
			// reasonable, otherwise the OS could choke
			// and crash our program
			let resizedImage = resizeImage(original: loadedImage, newWidth: 200.0, newHeight: 200.0)
			if let resizedImage = resizedImage {
				// render the image as JPEG to reduce size
				return resizedImage.jpegData(compressionQuality: 0.75)
			}
		}
		
		return nil
	}
	
	static func makeImage(data: Data) throws -> UIImage? {
		let renderedImage = UIImage(data: data)
		return renderedImage
	}
}

