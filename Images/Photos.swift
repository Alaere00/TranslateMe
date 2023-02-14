//
//  ImageApi.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/1/23.
//

import SwiftUI


struct PhotoPicker: View {
    @State var isPickerShowing = false
    @Binding var selectedImage: UIImage?
//    @State var selectedImage: UIImage?
    @State var selected : String = "English"


    var body: some View {
        VStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 400, height: 500, alignment: .center)
            } else {
            Rectangle()
                .fill(Color("Color"))
                .overlay(Text("Upload Images here"))
                .foregroundColor(.gray)
                .frame(width: 500, height: 500, alignment: .center)
                

            }
            HStack {
            Button {
                isPickerShowing = true
            } label: {
                Text("Select Image")
                    .frame(width: 120, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                
                }
                LangSelector(selected: $selected)
                
                NavigationLink(destination: downloadView(selectedImage: selectedImage, selectedLang: selected)){
                    Text("Send")
                        .frame(width: 100, height: 50)
                        .background(.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                
            
            .sheet(isPresented: $isPickerShowing, onDismiss: nil){
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
                }
            }
           
        }

    }
}

struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker(selectedImage: .constant(UIImage(named: "example")))
    }
}
