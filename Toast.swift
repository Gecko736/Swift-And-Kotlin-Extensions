// Make the toastView and toastLabel components in the storyboard.
// Constrain them so that they're where you want them to be initially, before it's moved into the first position.
// I have the top of the label constrained to 1.5 * superview.centerY.
// The view is constrained around the label with vertical padding of 4 and horizontal padding of 8
// The label is not inside the view. It is in front of the view inside the view controller's top level view.
// And set the alphas of both to 0 in the storyboard.
// The toasts you see are programmatically generated copies of what you put in the storyboard.

import Foundation
import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var toastView: UIView!
	@IBOutlet var toastLabel: UILabel!
	private var toasts = [UIView]()
	private let toastGuard = DispatchSemaphore(value: 1)
	private var cornerRadius: CGFloat!
	
	override func viewDidLoad() {
		cornerRadius = toastView.frame.height / 2.5
	}
	
	func toast(_ text: String) {
		print("toast: \(text)")
		And.then {
			self.toastLabel.text = text
			self.toastLabel.sizeThatFits(CGSize(width: self.view.frame.width, height: self.toastLabel.frame.height))
		}
		And.then(after: 0.1) {
			let toastView = UIView(frame: self.toastView.frame)
			toastView.backgroundColor = .clear
			toastView.frame.origin.y = self.toastView.frame.origin.y
			toastView.alpha = 0.9
			let toastLabel = UILabel(frame: self.toastLabel.frame)
			toastLabel.textColor = .clear
			toastLabel.textAlignment = .center
			toastLabel.lineBreakMode = .byWordWrapping
			toastLabel.text = text
			toastLabel.font = self.toastLabel.font
			toastLabel.numberOfLines = 2
			DispatchQueue(label: String.randomHex(ofLength: 6), qos: .utility).async {
				self.toastGuard.wait()
				And.then {
					self.view.addSubview(toastLabel)
					self.view.addSubview(toastView)
					self.view.bringSubviewToFront(toastLabel)
					toastView.layer.cornerRadius = self.cornerRadius
					self.toasts.append(contentsOf: [toastView, toastLabel])
					UIView.animate(withDuration: 0.2, delay: 0.01, options: .curveEaseInOut, animations: {
						toastView.backgroundColor = self.toastView.backgroundColor
						toastLabel.textColor = self.toastLabel.textColor
						for toast in self.toasts {
							toast.frame.origin.y -= toastView.frame.height + 4
						}
					}, completion: { _ in
						self.toastGuard.signal()
					})
				}
				And.then {
					UIView.animate(withDuration: 1, delay: 1.5, options: .curveEaseIn, animations: {
						toastView.alpha = 0
						toastLabel.alpha = 0
					}, completion: { _ in
						toastLabel.removeFromSuperview()
						toastView.removeFromSuperview()
						self.toasts.removeFirst(2)
					})
				}
			}
		}
	}
}
