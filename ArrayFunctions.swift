import Foundation

extension Array {
	public var isNotEmpty: Bool { !isEmpty }
	
	public var randomIndex: Int { Int.random(in: 0..<count) }
}

extension Array where Element == UInt8 {
	
	init(count: Int, _ getByte: (Int) -> UInt8) {
		self.init(repeating: 0, count: count)
		for i in indices {
			self[i] = getByte(i)
		}
	}
	
	func toPrintable() -> String {
		var str = ""
		if self.count < 32 {
			for i in self.indices {
				if i % 4 == 0 && i != 0 {
					str += " "
				}
				str += String(format: "%02X", self[i])
			}
		} else {
			for i in 0..<24 {
				if i % 4 == 0 && i != 0 {
					str += " "
				}
				str += String(format: "%02X", self[i])
			}
			str += " ..."
			for i in (((self.count / 4) - 1) * 4)..<self.count {
				if i % 4 == 0 {
					str += " "
				}
				str += String(format: "%02X", self[i])
			}
		}
		return str
	}
}

extension Array where Element: Equatable {
	public func contains(_ element: Element) -> Bool {
		for e in self {
			if e == element {
				return true
			}
		}
		return false
	}
	
	public func index(of element: Element) -> Int? {
		for i in self.indices {
			if self[i] == element {
				return i
			}
		}
		return nil
	}
	
	public static func - (lhs: Array<Element>, rhs: Element) -> Array<Element> {
		if !lhs.contains(rhs) { return lhs }
		var new = [Element]()
		for element in lhs {
			if element != rhs {
				new.append(element)
			}
		}
		return new
	}
	
	public static func - (lhs: Array<Element>, rhs: Array<Element>) -> Array<Element> {
		var new = [Element]()
		for element in lhs {
			if !rhs.contains(element) {
				new.append(element)
			}
		}
		return new
	}
	
	public func subset(from: Int, to: Int) -> [Element] {
		var subset = [Element]()
		for i in from..<to {
			subset.append(self[i])
		}
		return subset
	}
}
