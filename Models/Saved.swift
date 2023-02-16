//
//  Saved.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/1/23.
//

import SwiftUI
import FirebaseFirestore

struct Saved: View {
    @State private var fileManagersWithImages = [FileManagerWithImages]()
    @State private var showMenu = false
    @State private var isOn = false
    
    var body: some View {
        VStack {
            Text("Collections").font(.system(size: 30)).bold()
                .foregroundColor(.black)
                .background(Color(.white))
            
            List {
                ForEach(fileManagersWithImages, id: \.self) { fileManager in
                    NavigationLink(destination: ImageView(fileManager: fileManager)) {
                        Text(fileManager.name)
                    }
                }.onDelete(perform: deleteFileManager)
                
            }.background(Color("cornflower"))
                .navigationBarTitle("")
                .onAppear(perform: retrieveData)
        }
    }
    
    private func retrieveData() {
        Firestore.firestore().collection("collections").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error:/\(error)")
                return
            }
            
            let foldersData = querySnapshot!.documents.reduce(into: [String: [String]](), { result, document in
                let folderName = document.get("folderName") as? String ?? ""
                let imageURLs = document.get("images") as? [String] ?? []
                result[folderName, default: []].append(contentsOf: imageURLs)
            })
            
            self.fetchImages(for: foldersData) { imagesByFolders in
                let folders = imagesByFolders.map({ folder in
                    let folderName = folder.key
                    let images = folder.value
                    return FileManagerWithImages(name: folderName, images: images)
                })
                self.fileManagersWithImages = folders
            }
        }
    }
    
    private func fetchImages(for foldersData: [String: [String]], completion: @escaping ([String: [UIImage]]) -> Void) {
        let dispatchedGroup = DispatchGroup()
        var imagesByFolders = [String: [UIImage]]()
        
        for folderData in foldersData {
            let folderName = folderData.key
            let urls = folderData.value
            imagesByFolders[folderName] = []
            for url in urls {
                guard let imageURL = URL(string: url) else { continue }
                dispatchedGroup.enter()
                URLSession.shared.dataTask(with: imageURL) { data, _, error in
                    defer { dispatchedGroup.leave() }
                    if let error = error {
                        print("Your error is:/\(error)")
                        return
                    }
                    if let data = data, let image = UIImage(data: data) {
                        imagesByFolders[folderName]?.append(image)
                    }
                }.resume()
            }
        }
        
        dispatchedGroup.notify(queue: .main) {
            completion(imagesByFolders)
        }
    }
    
    
    func deleteFileManager(at offsets: IndexSet){
        let db = Firestore.firestore()
        
        for index in offsets {
            let fileManager = fileManagersWithImages[index]
            db.collection("collections").whereField("folderName", isEqualTo: fileManager.name)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            
            fileManagersWithImages.remove(at: offsets.first!)
        }
    }
}

struct ImageView: View {
    @State var fileManager: FileManagerWithImages
    @State var currentScale: CGFloat = 0
    @State var finalScale: CGFloat = 1

    var body: some View {
        VStack {
            Text("\(fileManager.name)")
                .foregroundColor(.black)
                .padding()
            ScrollView {
                    ForEach(0 ..< fileManager.images.count, id: \.self) { image in
                        Image(uiImage: self.fileManager.images[image])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(finalScale + currentScale)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { newScale in
                                        currentScale = newScale
                                    }
                                    .onEnded { scale in
                                        finalScale = scale
                                        currentScale = 0
                                    }
                            )
                }
            }
            .background(.gray)
            .ignoresSafeArea(.all)
        
        }
    }
}


struct Saved_Previews: PreviewProvider {
    static var previews: some View {
        Saved()
    }
}

