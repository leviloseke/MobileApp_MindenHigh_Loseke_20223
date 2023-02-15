//
//  PhotoDetailsViewController.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/11/23.
//

import UIKit

class PhotoDetailsViewController: UITableViewController {
    
    var photo: Photo!
    var photoImagePaths: [String] {return photo.allImagePaths }
    var imageCache: ImageCache?
    
    let firestore = FirestoreService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = tableView.bounds.width
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoImagePaths.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
        
        let imageCell = cell as? ImageCell
        imageCell?.imageCache = imageCache
        let imagePath = photoImagePaths[indexPath.row]
        imageCell?.populate(with: imagePath)
        
        return cell
    }
}
    
    

 
