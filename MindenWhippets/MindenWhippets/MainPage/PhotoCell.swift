//
//  ImageCell.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/8/23.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    
    var imageCache: ImageCache?
    
    func populate(with photo: Photo) {
        photoLabel.text = photo.title
        imageCache?.getImage(named: photo.mainImagePath, completion: { [weak self] (image) in
            self?.photoView.image = image
        })
    }
}
