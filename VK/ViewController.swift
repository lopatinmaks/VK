import UIKit

final class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private var myScrollView: UIScrollView!
    @IBOutlet private var loginLabel: UILabel!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordLabel: NSLayoutConstraint!
    @IBOutlet private var passwordTextField: UITextField!
    
    //MARK: - Methods for keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        myScrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        myScrollView.contentInset = contentInsets
        myScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        myScrollView.contentInset = UIEdgeInsets.zero
        myScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        myScrollView.endEditing(true)
    }
    
    //MARK: - IBAction
    @IBAction func enterButton(_ sender: UIButton) {
        
        guard let loginText = loginTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        
        if loginText == "Maksim", passwordText == "12345" {
            print("Добро пожаловать!")
        } else {
            print("Пароль и/или логин введены не правильно!")
        }
    }
}
