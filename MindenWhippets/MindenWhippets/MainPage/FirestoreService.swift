//
//  FirestoreService.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/11/23.
//
import FirebaseFirestore
import Foundation

class FirestoreService {
    
    
    private init() {}
    static let shared = FirestoreService()
    
    private var database: Firestore!
    private lazy var photoReference = database.collection("photos")
    
    func configure() { 
        database = Firestore.firestore()
}
    func save(_ photo: Photo, completion: @escaping (Result<Bool, NSError>) -> Void) {
      
        var otherImagePathsDict =   [String: String]()
        
        photo.otherImagePaths.forEach { otherImagePathsDict[UUID().uuidString] = $0 }
        
        photoReference.addDocument(data: ["mainImagePath" : photo.mainImagePath,
                                          "title": photo.title,
                                          "otherImagePaths": otherImagePathsDict
        ]) { (error) in
            
            if let unwrappedError = error {
                completion(.failure(unwrappedError as NSError))
            } else {
                completion(.success(true))
            }
        }
    }
    
    
    func listen(completion: @escaping ([Photo]) -> Void ) {
        photoReference.addSnapshotListener { (snapshot, error) in
            
            guard let unwrappedSnapshot = snapshot else { return }
            
            let documents = unwrappedSnapshot.documents
            
            var photos  = [Photo]()
            for document in documents {
                let documentData = document.data()
                
                guard
                    let mainImagePath = documentData["mainImagePath"] as?  String,
                    let title = documentData["title"] as? String,
                    let otherImagePathsDict  = documentData["otherImagePaths"] as? [String: String]
                else { continue }
                
                let otherImagePaths = otherImagePathsDict.map { $0.value }
                
                let photo = Photo(mainImagePath: mainImagePath, title: title, otherImagePaths: otherImagePaths)
                
                photos.append(photo)
                
            }
            completion(photos)
        }
    }
}
