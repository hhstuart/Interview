import Foundation

extension DateFormatter {
	static let swDate : DateFormatter = { () -> DateFormatter in
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		formatter.calendar = Calendar(identifier: .iso8601)
		return formatter
	}()
}

struct IndividualJSON : Codable {
	let id: Int
	let firstName: String
	let lastName: String
	let birthdate: Date
	let profilePicture: URL
	let forceSensitive: Bool
	let affiliation: String
}

struct IndividualsJSON : Codable {
	let individuals: [IndividualJSON]
}

func LoadIndividualsJSON(data: Data) throws -> [IndividualJSON] {
	let decode = JSONDecoder()
	decode.dateDecodingStrategy = .formatted(DateFormatter.swDate)
	let result = try decode.decode(IndividualsJSON.self, from: data)
	return result.individuals
}
