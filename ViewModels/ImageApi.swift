//
//  ImageApi.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/1/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct PhotoPicker: View {
    @State var isPickerShowing = false
    @Binding var selectedImage: UIImage?

    
    var body: some View {
        ZStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
    
            }
           
            Button {
                isPickerShowing = true
            } label: {
                Text("Upload File")
            
        }
            .sheet(isPresented: $isPickerShowing, onDismiss: nil){
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
        }
            
    }
}

