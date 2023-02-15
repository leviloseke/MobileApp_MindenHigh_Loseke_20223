//
//  Photo.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/8/23.
//

import Foundation

struct Photo: Decodable {
    let mainImagePath: String
    let title: String
    let otherImagePaths: [String]
    
    var allImagePaths: [String] { return [mainImagePath] + otherImagePaths}
}
