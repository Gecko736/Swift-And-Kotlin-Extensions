import UIKit

extension UIView {
    public var isVisible: Bool {
        get { return !isHidden }
        set { isHidden = !newValue }
    }
    public var darkMode: Bool {
        get { if #available(iOS 13, *), traitCollection.userInterfaceStyle == .dark { return true } else { return false } }
    }
}
