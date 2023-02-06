//
//  downLoadView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/5/23.
//

import UIKit
import FirebaseStorage
import SwiftUI

struct downLoadView: View {
    @State private var selectedImage: UIImage?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    func downloadImage(docId: String){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let docRef = storageRef.child("images/new_\(docId)")
        
        docRef.getData(maxSize: 1 * 1024 * 1024){ data, error in
            if let error = error {
                print("error\(error)")
            } else {
                let selectedImage = UIImage(data : data!)
                self.selectedImage = selectedImage
                }
            }
        
    }
}

struct downLoadView_Previews: PreviewProvider {
    static var previews: some View {
        downLoadView()
    }
}



