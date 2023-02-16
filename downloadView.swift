//
//  downLoadView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/5/23.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import SwiftUI

struct FileManagerWithImages : Hashable {
    var name: String
    var images: [UIImage]
}



struct downloadView: View {
    let selectedImage: UIImage?
    let selectedLang: String
    @State var selectedOption = 0
    @State var storageImage: UIImage?
    @State private var folderName = ""
    @State var fileManagersWithImages = [FileManagerWithImages]()
    @State var collections: [String] = []
    @State private var selectedCollection: String = ""

    
    
    var body: some View {
        VStack {
            if let storageImage = storageImage {
                Image(uiImage: storageImage)
                    .resizable()
                    .frame(width: 500, height: 500)
                
                
                    HStack {
                        TextField("Enter text", text: $folderName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .shadow(radius: 5)
                        

                        Button(action: {
                            let fileManagerWithImages = FileManagerWithImages(name: self.folderName, images: [storageImage])
                            
                            let imageData = storageImage.jpegData(compressionQuality: 0.75)
                            let imageReference = Storage.storage().reference().child("collections/\(UUID().uuidString)")
                            imageReference.putData(imageData!, metadata: nil) { (metadata, error) in
                                if let error = error {
                                    print("Error:/\(error)")
                                    return
                                }
                                
                                imageReference.downloadURL { (url, error) in
                                    if let error = error {
                                        print("Error:/\(error)")
                                        return
                                    }
                                    
                                    let imageURL = url?.absoluteString ?? ""
                                    
                                    Firestore.firestore().collection("collections").whereField("folderName", isEqualTo: fileManagerWithImages.name).getDocuments { (querySnapshot, error) in
                                        if let error = error {
                                            print("Error:/\(error)")
                                            return
                                        }
                                        
                                        if querySnapshot!.documents.count > 0 {
                                            let documentID = querySnapshot!.documents.first!.documentID
                                            Firestore.firestore().collection("collections").document(documentID).updateData([
                                                "images": FieldValue.arrayUnion([imageURL])
                                            ]) { (error) in
                                                if let error = error {
                                                    print("Error:/\(error)")
                                                    return
                                                }
                                                
                                                print("Data updated successfully")
                                            }
                                        } else {
                                            let fileManagerWithImagesData: [String: Any] = [
                                                "folderName": fileManagerWithImages.name,
                                                "images": [imageURL]
                                            ]
                                            
                                           
                                            
                                            Firestore.firestore().collection("collections").addDocument(data: fileManagerWithImagesData) { (error) in
                                                if let error = error {
                                                    print("Error:/\(error)")
                                                    return
                                                }
                                                
                                                print("Data added successfully")
                                            }
                                        }
                                    }
                                }
                            }
                        }) {
                            Text("Save Image")
                                .padding(10)
                                .background(.blue)
                                .foregroundColor(.white)
                            
                        }.cornerRadius(10)
                        Spacer()
                    }
                    .padding(.top, 20)
                
                
                
                HStack {
                    NavigationLink(destination: Saved()) {
                        Text("See collections")
                    }.padding(15)
                        .foregroundColor(.white)
                        .background(.yellow)
                        .cornerRadius(10)
                    
                    Button("Download to library") {
                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: storageImage)
                        
                    }.padding(15)
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                }
                
                
            } else {
                LoadingView(tintColor: Color("Color"), scaleSize: 2.0).padding(.bottom, 40)
                Text("Loading...")
            }
        }
        .onAppear {
            uploadPhotoAndLang(selectedImage: selectedImage, selectedLang: selectedLang)
        
    }
        
}

    func uploadPhotoAndLang(selectedImage: UIImage?, selectedLang: String) {
        guard let selectedImage = selectedImage else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        
        let imageData = selectedImage.jpegData(compressionQuality: 1.0)
        let imageName = UUID().uuidString
        
        guard imageData != nil else {
            return
        }
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child("images/\(imageName).jpg")
        
        fileRef.putData(imageData!, metadata: nil) { metadata,
            error in
            
            if error == nil && metadata != nil {
                
                let db = Firestore.firestore()
                let docRef = db.collection("images").document()
                docRef.setData(["image_name": imageName, "url": path, "language": selectedLang, "new_URL": ""]){ err in
                    if err == nil {
                        sendPatchRequest(docId: docRef.documentID)
                    }
                }
            }
        }
    }
    
    func sendPatchRequest(docId: String){
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
                print(responseJSON)
                
                if let newURL  = responseJSON["new_URL"] as? String {
                    retrieveImages(newURL: newURL)
                    return
                } else {
                    print("Could not retrieve image")
                }
                
            }
        }
        task.resume()
        
    }
    func retrieveImages(newURL: String){
        
        
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("images/\(newURL)")
        fileRef.getData(maxSize: 3 * 1024 * 1024){ data, error in
            if error == nil {
                if let imageData = UIImage(data: data!)?.jpegData(compressionQuality: 1.0) {
                    if let storageImage = UIImage(data: imageData){
                        DispatchQueue.main.async{
                            
                            let resizedImage = storageImage.resizeImage(targetSize: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                            
                            self.storageImage = resizedImage
                            
                            
                            
                            }
                            fileRef.delete { error in
                            if let error = error {
                                print("Error deleting old image: \(error)")
                            } else {
                                print("New image deleted successfully")
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
        }
    }
}
                        
  
    

extension UIImage {
      func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
      }
    }



struct LoadingView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: UIImage?) -> some View {
        if shouldHide == nil {
            self.hidden()
        } else {
            self
        }
    }
}



