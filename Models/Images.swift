//
//  Images.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/29/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct TextImage: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURLString = ""
    var collection = ""
    var languageTo = ""
    var postedOn = Date()
    
    var dictionary: [String: Any]{
        return ["imageURLString": imageURLString, "collection": collection, "languageTo": languageTo, "postedOn": Timestamp(date: Date())]
    }
}
