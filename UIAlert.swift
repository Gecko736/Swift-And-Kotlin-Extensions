import UIKit

extension UIAlertAction {
    convenience init(title: String, handler: @escaping (UIAlertAction) -> ()) {
        self.init(title: title, style: .default, handler: handler)
    }
    
    public static let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    public static func OK(_ handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        return UIAlertAction(title: "OK", handler: handler)
    }
}

class UIAlert {
    static func show(error: Error, from sender: UIViewController) {
        show(title: "Error", message: error.localizedDescription, sender: sender)
    }
    
    static func show(title: String, message: String, sender: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.OK)
        sender.present(alert, animated: true, completion: nil)
    }
    
    static func show(title: String, message: String, sender: UIViewController, okAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.OK { _ in okAction() })
        sender.present(alert, animated: true, completion: nil)
    }
    
    static func show(title: String, message: String, sender: UIViewController, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions { alert.addAction(action) }
        sender.present(alert, animated: true, completion: nil)
    }
}
