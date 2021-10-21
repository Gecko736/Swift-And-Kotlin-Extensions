import android.app.Dialog
import android.view.View
import android.view.Window
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.view.ViewCompat
import com.bundle.yourproject.R

class UIAlert(title: String, message: String?, action1: Action?, action2: Action?, autoDismissWindow: Boolean = true, onCreateTextField: ((EditText) -> Unit)? = null) {
	
	companion object {
		fun yesOrNo(title: String, message: String?, callback: (Boolean) -> Unit) =
			UIAlert(title, message, Action("yes") { callback(true) }, Action("no") { callback(false) }).show()
		
		fun show(title: String, message: String?, action1: Action?, action2: Action?, autoDismissWindow: Boolean = true, onCreateTextField: ((EditText) -> Unit)? = null) = main.runOnUiThread {
			UIAlert(title, message, action1, action2, autoDismissWindow, onCreateTextField).show()
		}
		
		fun ok(title: String, message: String? = null, onOkCallback: () -> Unit = {}) = main.runOnUiThread {
			UIAlert(title, message, Action("OK") { onOkCallback() }, null).show()
		}
	}
	
	val dialog: Dialog
	val titleLabel: TextView
	val messageLabel: TextView
	val textField: EditText
	val button1: Button
	val button2: Button
	
	init {
		val view = main.layoutInflater.inflate(R.layout.dialog_alert, null, false)
		view.id = ViewCompat.generateViewId()
		view.layoutParams = ConstraintLayout.LayoutParams(ConstraintLayout.LayoutParams.MATCH_PARENT, ConstraintLayout.LayoutParams.MATCH_PARENT)
		
		dialog = Dialog(main)
		dialog.window?.setBackgroundDrawableResource(R.drawable.nothing)
		dialog.requestWindowFeature(Window.FEATURE_NO_TITLE)
		dialog.setContentView(view)
		dialog.setCancelable(false)
		
		titleLabel = view.findTextView(R.id.title_label)
		messageLabel = view.findTextView(R.id.message_label)
		textField = view.findEditText(R.id.text_field)
		button1 = view.findButton(R.id.button_1)
		button2 = view.findButton(R.id.button_2)
		
		titleLabel.text = title
		
		if (message != null)
			messageLabel.text = message
		else
			messageLabel.visibility = View.GONE
		
		if (onCreateTextField != null)
			onCreateTextField(textField)
		else
			textField.visibility = View.GONE
		
		if (action1 != null) {
			button1.text = action1.title
			button1.setOnClickListener {
				action1.action(this)
				if (autoDismissWindow)
					dismiss()
			}
			
			if (action2 != null) {
				button2.text = action2.title
				button2.setOnClickListener {
					action2.action(this)
					if (autoDismissWindow)
						dismiss()
				}
			} else
				button2.visibility = View.GONE
			
		} else if (action2 != null) {
			button1.text = main.resources.getText(R.string.cancel)
			button1.setOnClickListener { dismiss() }
			
			button2.text = action2.title
			button2.setOnClickListener {
				action2.action(this)
				if (autoDismissWindow)
					dismiss()
			}
		} else {
			button1.text = main.resources.getText(R.string.ok)
			button1.setOnClickListener { dismiss() }
			
			button2.visibility = View.GONE
		}
	}
	
	fun show() = main.runOnUiThread { dialog.show() }
	
	fun dismiss() = main.runOnUiThread { dialog.dismiss() }
	
	class Action(val title: String, val action: (UIAlert) -> Unit = {  })
}