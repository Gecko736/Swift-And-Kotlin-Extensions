extension UInt8 {
	var toHex: String { String(format: "%02X", self) }
	
	private static let masks: [UInt8] = [0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01]
	subscript(index: Int) -> Bool { (self & UInt8.masks[index]) == UInt8.masks[index] }
}

extension Bool {
	var toByte: UInt8 {
		if self { return 1 }
		else { return 0 }
	}
	
	static func random(chance: Float = 0.5) -> Bool { Float(arc4random()) / Float(UINT32_MAX) < chance }
}

extension UInt16 {
	var toHex: String { String(format: "%04X", self) }
	
	var hiByte: UInt8 { UInt8(self >> 8) }
	
	var loByte: UInt8 { UInt8(self & 0xFF) }
	
	private static let masks: [UInt16] = [
		0x8000, 0x4000, 0x2000, 0x1000, 0x0800, 0x0400, 0x0200, 0x1000,
		0x0080, 0x0040, 0x0020, 0x0010, 0x0008, 0x0004, 0x0002, 0x0001
	]
	subscript(index: Int) -> Bool { (self & UInt16.masks[index]) == UInt16.masks[index] }
}
