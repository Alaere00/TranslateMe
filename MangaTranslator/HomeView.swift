//
//  HomeView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/29/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore


struct HomeView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var showMenu = false
//    @State var selectedImage: UIImage?

    var body: some View {
        VStack {
            Spacer()
            ImageAndLangView()
                .padding()
            .frame(maxHeight: .infinity)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            HomeView()
    }
}
