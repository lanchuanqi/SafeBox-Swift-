//
//  AddImageViewController.swift
//  Final
//
//  Created by logan on 7/27/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import CoreData
class AddImageViewController: UIViewController {

    @IBOutlet weak var photoTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveButton(_ sender: AnyObject) {
        if photoTextfield.text == ""{
            let alert = UIAlertController(title: "Error", message: "Can't save with no name!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: {(alertAction)in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext!
            let en = NSEntityDescription.entity(forEntityName: "Album", in: context)
        
            let newAlbum = Model(entity: en!, insertInto: context)
            newAlbum.name = photoTextfield.text
            if let userInfo = appDel.loggedInUser {
                newAlbum.user = userInfo
            }
        
            
            do {
                // save context
                try context.save()
            } catch _ {
            }
        
            // navegate to table view controller
            self.navigationController?.popViewController(animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
