//
//  ImageCell.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/11/23.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageCache: ImageCache?
    
    func populate(with imagePath: String) {
        imageCache?.getImage(named: imagePath, completion: { [weak self] (image) in
            self?.photoImageView.image = image
        })
    }
}


