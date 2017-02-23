//
//  LoginViewController.swift
//  Final
//
//  Created by logan on 7/25/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import CoreData


protocol LoginViewControllerDelegate: class {
    func loginViewController(_ controller: LoginViewController, didLoginWithUserInfo userInfo: UserInfo)
}


class LoginViewController: UIViewController {
    weak var delegate: LoginViewControllerDelegate?
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func btLogin(_ sender: AnyObject) {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", textUsername.text!)
        
        usernameLabel.text = textUsername.text
        passwordLabel.text = textPassword.text
        let results: NSArray = try! context.fetch(request) as NSArray
        
        if results.count > 0{
            let res = results[0] as! UserInfo
            if usernameLabel.text == res.username {
                if passwordLabel.text == res.password {
                    delegate?.loginViewController(self, didLoginWithUserInfo: res)
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Wrong Password!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: {(alertAction)in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: "User Does Not Exists!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: {(alertAction)in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)            }
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Wrong Password!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: {(alertAction)in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func btSignup(_ sender: AnyObject) {
        if textUsername.text != "" && textPassword.text != ""{
            let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext!
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            request.returnsObjectsAsFaults = false
            request.predicate = NSPredicate(format: "username = %@", textUsername.text!)
            
            usernameLabel.text = textUsername.text
            passwordLabel.text = textPassword.text
            let results: NSArray = try! context.fetch(request) as NSArray
            
            if results.count > 0{
                let alert = UIAlertController(title: "Error", message: "Username exists!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: {(alertAction)in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) 
                newUser.setValue(textUsername.text, forKey: "username")
                newUser.setValue(textPassword.text, forKey: "password")
                do {
                    try context.save()
                } catch _ {
                }
                let alert = UIAlertController(title: "Important", message: "Remember you username and password!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: {(alertAction)in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Username and Password can not be empty!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: {(alertAction)in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

