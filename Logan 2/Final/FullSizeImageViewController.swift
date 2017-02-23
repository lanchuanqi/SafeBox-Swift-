//
//  FullSizeImageViewController.swift
//  Final
//
//  Created by logan on 7/30/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import CoreData

class FullSizeImageViewController: UIViewController, UIScrollViewDelegate {

    var selectedImage: AllPhotos!
    var photosAlbum: Array<AllPhotos> = []
    
    @IBAction func CancelButton(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TrashButton(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Delete Image", message: "Are you sure you want to delete this image?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(alertAction) in
            let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext!
            context.delete(self.selectedImage)
            do {
                try context.save()
            } catch _ {
            }
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {(alertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var FullImageView: UIImageView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return FullImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnTap = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        FullImageView.image = UIImage(data: selectedImage.data as Data)
    }
    
}
