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
    @State var selected : String = "English"
    
    
    
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
                let docRef = db.collection("images").document()
                docRef.setData(["image_name": imageName, "url": path, "language": selectedLang, "new_URL": ""])
                
                sendPatchReques(docId: docRef.documentID){ response in
                    self.downloadImage(docId: response)
                }
                
            }
        }
    }
    func sendPatchReques(docId: String, completion: @escaping (String) -> Void){
        let url = URL(string: "http://127.0.0.1:5000/images/\(docId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error while making requests")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let newDocId = responseJSON["new_doc_id"] as! String
                completion(newDocId)
            }
        }
        task.resume()
    }
    func downloadImage(docId: String){
        let storageRef = Storage.storage().reference()
        let islandRef = storageRef.child("images/new_/\(docId).jpg")
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Could not find image")
                return
            } else {
                let image = UIImage(data: data!)
                self.selectedImage = image
            }
        }
    }
}





   



