//
//  ImageAndLangView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/1/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore


struct LangSelector: View {
    @Binding var selected : String
    let languageOptions = ["Arabic", "Chinese", "English", "German", "Indonesian", "Japanese", "Korean", "Russian", "Spanish"]

    var body: some View {
        
        VStack {
            Picker("Select a language", selection: $selected){
                ForEach(languageOptions, id: \.self){
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            Text("Translate language to: \(selected)")
        }
    }
}

struct ImageAndLangView: View {
    @State private var selectedImage: UIImage?
    @State private var selected : String = "English"

    
    var body: some View {
        VStack {
            PhotoPicker(selectedImage: $selectedImage)
            LangSelector(selected: $selected)
    
            Button(action: {
                self.uploadPhotoAndLang(selectedImage: self.selectedImage, selectedLang: self.selected)
            }) {
                Text("Send")
            }
        }
    }
    func uploadPhotoAndLang(selectedImage: UIImage?, selectedLang: String) {
        guard let selectedImage = selectedImage else {
            return
        }

        let storageRef = Storage.storage().reference()
        
        let imageData = selectedImage.jpegData(compressionQuality: 0.8)
        let imageName = UUID().uuidString
        
        guard imageData != nil else {
            return
        }

        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child("images/\(imageName).jpg")
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata,
            error in
            
            if error == nil && metadata != nil {
                
                let db = Firestore.firestore()
                db.collection("images").document().setData(["image_name": imageName, "url": path, "language": selectedLang, "new_URL": ""])
                
            }
        }
    }
}

//func sendUrl(){
//    guard let url = URL(string:"https://translate-me-alaere.herokuapp.com/")
//}


   



//}
//}
//func uploadPhotoAndLang(){
//guard selectedImage != nil else {
//    return
//}
//let storageRef = Storage.storage().reference()
//
//let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
//
//guard imageData != nil else {
//    return
//}
//let path = "images/\(UUID().uuidString).jpg"
//let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
//
//let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata,
//    error in
//
//    if error == nil && metadata != nil {
//
//        let db = Firestore.firestore()
//        db.collection("images").document().setData(["url": path])
//
//    }
//}
//}

