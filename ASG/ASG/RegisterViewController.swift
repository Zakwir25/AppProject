//
//  RegisterViewController.swift
//  ASG
//
//  Created by Rakha Aiman Mumtaz on 18/12/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTXT: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var ConfirmTxt: UITextField!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func registerBtn(_ sender: Any) {
        guard let username = usernameTXT.text, !username.isEmpty,
                     let email = emailTxt.text, !email.isEmpty,
                     let password = passwordTxt.text, !password.isEmpty,
                     let confirm = ConfirmTxt.text, !confirm.isEmpty else {
                   showAlert(with: "Error", message: "isi semua")
                   return
               }
               
               guard isValidEmail(email) else {
                   showAlert(with: "Error", message: "Invalid email format")
                   return
               }

               guard password.count >= 6 else {
                   showAlert(with: "Error", message: "Password harus 6 karakter")
                   return
               }

               guard password == confirm else {
                   showAlert(with: "Error", message: "Password dan Confirm Password tidak sama")
                   return
               }

               
               if saveUserToCoreData(username: username, email: email, password: password) {
                   showAlert(with: "Success", message: "User registered berhasil")
                   clearFields()
                   
                   
                   performSegue(withIdentifier: "NextLogin", sender: self)
               } else {
                   showAlert(with: "Error", message: "gagal regisrasi")
               }
           }

           func isValidEmail(_ email: String) -> Bool {
               let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
               let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
               return emailPredicate.evaluate(with: email)
           }

           func saveUserToCoreData(username: String, email: String, password: String) -> Bool {
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                   return false
               }

               let context = appDelegate.persistentContainer.viewContext

               let newUser = User(context: context)
               newUser.username = username
               newUser.email = email
               newUser.password = password

               do {
                   try context.save()
                   return true
               } catch {
                   return false
               }
           }

           func showAlert(with title: String, message: String) {
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }

           func clearFields() {
               usernameTXT.text = ""
               emailTxt.text = ""
               passwordTxt.text = ""
               ConfirmTxt.text = ""
           }
    }



