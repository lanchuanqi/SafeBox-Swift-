//
//  NoteTableViewController.swift
//  Final
//
//  Created by logan on 7/28/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController {
    @IBOutlet var noteTableView: UITableView!
    var selectedUser: UserInfo!
    var myList: Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        if let userInfo = appDel.loggedInUser {
            freq.predicate = NSPredicate(format: "user == %@", userInfo)
        }
        myList = try! context.fetch(freq)
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "noteCell")! //as! UITableViewCell
        let data: NSManagedObject = myList[(indexPath as NSIndexPath).row] as! NSManagedObject
        cell.textLabel!.text = data.value(forKeyPath: "notename") as? String
        
        
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        if editingStyle == UITableViewCellEditingStyle.delete{
            context.delete(myList[(indexPath as NSIndexPath).row] as! NSManagedObject)
            myList.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
        var error: NSError? = nil
        do {
            try context.save()
        } catch let error1 as NSError {
            error = error1
            abort()
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! as String == "showNotes"{
            let noteContorller = segue.destination as! NoteViewController
            let indexPath = self.noteTableView.indexPath(for: sender as! UITableViewCell)
            let note: NoteModel = myList[(indexPath! as NSIndexPath).row] as! NoteModel
            noteContorller.selectedNote = note
            noteContorller.barTitle = note.notename
        }
    }
    

}
