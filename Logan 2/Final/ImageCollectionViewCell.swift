//
//  ImageCollectionViewCell.swift
//  Final
//
//  Created by logan on 7/29/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    func setImage(_ neededImage: UIImage!){
        self.ImageView.image = neededImage
    }
}
