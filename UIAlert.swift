import UIKit

extension UIAlertAction {
    convenience init(title: String, handler: @escaping (UIAlertAction) -> ()) {
        self.init(title: title, style: .default, handler: handler)
    }
    
    public static let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    public static func OK(_ handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        return UIAlertAction(title: "OK", handler: handler)
    }
	
	public static let CANCEL = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
	
	public static func CANCEL(_ handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
		return UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
	}
}

extension UIViewController {
	func popUp(error: Error, _ okAction: @escaping () -> () = { }) {
		popUp(title: "Error", message: error.localizedDescription, okAction: okAction)
	}
	
	func popUp(title: String, message: String? = nil) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(.OK)
		present(alert, animated: true, completion: nil)
	}
	
	func popUp(title: String, message: String? = nil, okAction: @escaping () -> ()) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(.OK { _ in okAction() })
		present(alert, animated: true, completion: nil)
	}
	
	func popUp(title: String, message: String? = nil, actions: [UIAlertAction]) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		for action in actions { alert.addAction(action) }
		present(alert, animated: true, completion: nil)
	}
	
	func actionSheet(_ actions: [UIAlertAction]) {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		for action in actions {
			alert.addAction(action)
		}
		present(alert, animated: true, completion: nil)
	}
}
