//
//  LiveFeedViewController.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/8/23.

import UIKit

class LiveFeedViewController: UITableViewController {
    
    var photos = [Photo]()
    
    let firestore = FirestoreService.shared
    
    let imageCache = ImageCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firestore.configure()
        
        tableView.rowHeight = (tableView.bounds.width * 8) / 15
        firestore.listen { [weak self] (photos) in
            self?.photos = photos
            self?.tableView.reloadData()
        }
    }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
        return photos.count
        }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
            
            let photoCell = cell as? PhotoCell
            photoCell?.imageCache = imageCache
            let photo = photos[indexPath.row]
            photoCell?.populate(with: photo)
            
            return cell
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let newPostVC = segue.destination as? NewPostViewController {
            newPostVC.firestore = firestore
            
        } else if let photoDetailsVC = segue.destination as?
                    PhotoDetailsViewController, let photo = sender as? Photo {
            photoDetailsVC.photo = photo
            photoDetailsVC.imageCache = imageCache
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        performSegue(withIdentifier: "segue", sender: photo)
        
    }
    
    
    }

