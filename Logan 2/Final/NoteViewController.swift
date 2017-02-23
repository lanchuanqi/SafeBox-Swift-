//
//  NoteViewController.swift
//  Final
//
//  Created by logan on 8/4/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    var selectedNote: NoteModel!
    var barTitle: String!
    
    
    
    @IBAction func noteSaveButton(_ sender: AnyObject) {
        selectedNote.notedetail = self.noteTextView.text
        
        do {
            try selectedNote.managedObjectContext?.save()
        } catch _ {
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var noteTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
        self.navigationItem.title = barTitle
        self.noteTextView.text = selectedNote.notedetail
    }


}
