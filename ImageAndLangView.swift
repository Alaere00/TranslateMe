//
//  ImageAndLangView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/1/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
import SafariServices
import GameController
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
            .frame(width: 120, height: 50, alignment: .center)
            .foregroundColor(.white)
            .background(.green)
            .cornerRadius(10)
            
        }
    }
}


struct ImageAndLangView: View {
    @State private var selectedImage: UIImage?
    
    
    var body: some View {
        VStack {
            PhotoPicker(selectedImage: $selectedImage)

            }
        }
    }

    


struct ImageAndLangView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndLangView()
    }
}





