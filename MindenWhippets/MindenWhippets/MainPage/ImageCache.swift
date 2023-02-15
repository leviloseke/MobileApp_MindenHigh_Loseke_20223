//
//  ImageCache.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/11/23.
//
import UIKit
import Foundation


class ImageCache: NSCache<NSString, AnyObject> {
    
    
    func getImage(named imageName: String, completion: @escaping (UIImage?) -> Void) {
        
        if let image = object(forKey: imageName as NSString) as? UIImage {
            completion(image)
        } else {
            let url = URL(string: imageName)!
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    setObject(image, forKey: imageName as NSString)
                    completion(image)
                }
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}
