//
//  LoginViewController.swift
//  ASG
//
//  Created by Rakha Aiman Mumtaz on 18/12/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var Logo: UIImageView!
    
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "Logo")
        Logo.image = image

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        guard let username = usernameTxt.text, !username.isEmpty,
                  let password = passwordTxt.text, !password.isEmpty else {
                showAlert(with: "Error", message: "Please enter  username dan password.")
                return
            }

            if let user = fetchUserFromCoreData(username: username, password: password) {

                performSegue(withIdentifier: "NextAdmin", sender: nil)

            } else {
                showAlert(with: "Error", message: "Invalid username dan password")
            }
        
    }
    
    
    @IBAction func loginUser(_ sender: Any) {
        guard let username = usernameTxt.text, !username.isEmpty,
                  let password = passwordTxt.text, !password.isEmpty else {
                showAlert(with: "Error", message: "Please enter  username dan password.")
                return
            }

            if let user = fetchUserFromCoreData(username: username, password: password) {

                performSegue(withIdentifier: "NextUser", sender: nil)

            } else {
                showAlert(with: "Error", message: "Invalid username dan password")
            }
        

    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
        performSegue(withIdentifier: "NextRegister", sender: self)
        
    }
    
    func fetchUserFromCoreData(username: String, password: String) -> User? {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return nil
           }

           let context = appDelegate.persistentContainer.viewContext

           let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

           do {
               let users = try context.fetch(fetchRequest)
               return users.first
           } catch {
               return nil
           }
       }

       func showAlert(with title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }

}
