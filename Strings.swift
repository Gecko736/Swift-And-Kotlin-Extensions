import Foundation

extension String {
	public func format(_ args: CVarArg...) -> String { String(format: self, args) }
	
	public func matches(regex: String) -> Bool {
		guard let rgx = try? NSRegularExpression(pattern: regex) else { return false }
		return rgx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) != nil
	}
	
	public var withoutNewlinesOrTabs: String {
		var chars = ""
		for char in self {
			if char != "\n" && char != "\t" {
				chars += "\(char)"
			}
		}
		return chars
	}
	
	public var withoutSpaces: String { self.replacingOccurrences(of: " ", with: "") }
	
	public var withRandomCapitalization: String {
		self.map { char in
			if Float.random < 0.5 {
				return "\(char)".uppercased()
			} else {
				return "\(char)"
			}
		}.joined()
	}
	
	public static let hexAlphabet = "0123456789ABCDEF"
	public static func randomHex(ofLength length: Int) -> String {
		String((0..<length).map { _ in "\(String.hexAlphabet.randomElement()!)" }.joined())
	}
	
	private static let frequencyAlphabet = ["e", "t", "ainos", "h", "r", "d", "l", "u", "cm", "f", "wy", "gp", "b", "v", "k", "q", "jx", "z"]
	private static let characterFrequencies: [Float] = [0.1757, 0.3075, 0.4246, 0.5183, 0.6091, 0.6735, 0.7321, 0.7818, 0.8404, 0.8770, 0.9312, 0.9546, 0.9722, 0.9839, 0.9912, 0.9971, 1.0]
	public static func randomNonsense(ofLength length: Int) -> String {
		var sentence = ""
		var word = ""
		for _ in 0..<length {
			let chance = Float(1) / (0.2 * Float(word.count) + Float(1))
			if !word.isEmpty && Float.random > chance {
				sentence += word + " "
				word = ""
			} else {
				let float = Float.random
				for i in frequencyAlphabet.indices {
					if float <= characterFrequencies[i] {
						word += "\(frequencyAlphabet[i].randomElement()!)"
						break
					}
				}
			}
		}
		return sentence
	}
}

extension DateFormatter {
	convenience init(_ format: String) {
		self.init()
		self.dateFormat = format
	}
}
