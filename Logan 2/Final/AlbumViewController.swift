//
//  AlbumViewController.swift
//  Final
//
//  Created by logan on 7/29/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import Photos
import CoreData

class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var barTitle: String = ""
    var photosAlbum: Array<AllPhotos> = []
    var selectedAlbum: Model!
    
    @IBAction func CameraButton(_ sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)){
            let picker: UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.delegate = self
            picker.allowsEditing = false
            self.present(picker, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: {(alertAction)in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func FileButton(_ sender: AnyObject) {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picker.delegate = self
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var fileBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var cameraBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButtonItems = [fileBarButtonItem, cameraBarButtonItem]
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItems! = rightButtonItems as! [UIBarButtonItem]
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        freq.predicate = NSPredicate(format: "album == %@", selectedAlbum)
        photosAlbum = (try! context.fetch(freq)) as! Array<AllPhotos>
        ImageCollectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
        self.navigationItem.title = barTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return photosAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        let img = photosAlbum[(indexPath as NSIndexPath).item]
        cell.setImage(UIImage(data: img.data))
        
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! as String == "showFullSize"{
            let fullsizeController = segue.destination as! FullSizeImageViewController
            let indexPath = self.ImageCollectionView.indexPath(for: sender as! UICollectionViewCell)
            let photo = photosAlbum[(indexPath! as NSIndexPath).item]
            fullsizeController.selectedImage = photo
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entity(forEntityName: "Photo", in: context)
        let newAlbum = AllPhotos(entity: en!, insertInto: context)
        newAlbum.data = UIImageJPEGRepresentation(image, 0.9)
        newAlbum.album = selectedAlbum
        do {
            // edit
        
            
        
            // save context
            try context.save()
        } catch _ {
        }
        
        picker.dismiss(animated: true, completion: nil)
        ImageCollectionView.reloadData()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
