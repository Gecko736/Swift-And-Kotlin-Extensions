extension UInt8 {
	var toHex: String { String(format: "%02X", self) }
	
	subscript(index: Int) -> Bool {
		switch index {
		case 0: return (self & 0x80) == 0x80
		case 1: return (self & 0x40) == 0x40
		case 2: return (self & 0x20) == 0x20
		case 3: return (self & 0x10) == 0x10
		case 4: return (self & 0x08) == 0x08
		case 5: return (self & 0x04) == 0x04
		case 6: return (self & 0x02) == 0x02
		case 7: return (self & 0x01) == 0x01
		default: fatalError("Index \(index) out of range in byte \(toHex)")
		}
	}
}

extension Bool {
	var toByte: UInt8 {
		if self { return 1 }
		else { return 0 }
	}
	
	static func random(chance: Float = 0.5) -> Bool { Float(arc4random()) / Float(UINT32_MAX) < chance }
}

extension UInt16 {
	var toHex: String { "\(hiByte.toHex)\(loByte.toHex)" }
	
	var hiByte: UInt8 { UInt8(self >> 8) }
	
	var loByte: UInt8 { UInt8(self & 0xFF) }
}
