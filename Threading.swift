import Foundation

class And {
    public enum Where {
        case main
        case background
    }
    
    private static let backgroundThread = DispatchQueue(label: "background", qos: .background, attributes: .initiallyInactive, target: .none)
    
    public static func then(in thread: Where = .main, after seconds: Double = 0, _ action: @escaping () -> ()) {
        switch thread {
        case .main:
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { autoreleasepool { action() } }
            break
        default:
            backgroundThread.asyncAfter(deadline: .now() + seconds) { autoreleasepool { action() } }
        }
    }
}
