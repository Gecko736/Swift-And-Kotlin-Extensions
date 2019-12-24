import Foundation

extension Array {
    public var isNotEmpty: Bool {
        get { return !isEmpty }
    }
    
    public var randomIndex: Int {
        get { return Int.random(in: 0..<count) }
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
        var i = 0
        for e in self {
            if e == element {
                return i
            }
            i += 1
        }
        return nil
    }
}
