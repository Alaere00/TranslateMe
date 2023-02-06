//
//  ImageAndLangView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/1/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
//import UIKit
//import PhotosUI


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
            .background(.white)
            .cornerRadius(10)
            .foregroundColor(.white)
        }
    }
}


struct ImageAndLangView: View {
    @State private var selectedImage: UIImage?
    @State var selected : String = "English"
    
    
    var body: some View {
        VStack {
            Spacer()
            LangSelector(selected: $selected)
            
            PhotoPicker(selectedImage: $selectedImage)
            
            
//            NavigationLink(destination: downloadView(selectedImage: selectedImage, selectedLang: selected)){
//                Text("Send")
//                    .frame(width: 100, height: 50)
//                    .background(.green)
//                    .cornerRadius(10)
//                    .foregroundColor(.white)
                Spacer()
                
                
            }
        }
    }

    


struct ImageAndLangView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndLangView()
    }
}





