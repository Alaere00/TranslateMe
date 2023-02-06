//
//  ContentView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/29/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {
    @State private var showMenu = false
    @State var selected : String = "English"
    @State private var selectedImage: UIImage?
    @State private var tabSelected: Tab = .house
    
    
    var body: some View {
        ZStack {
            NavigationView {
                TabView(selection: $tabSelected) {
                    switch tabSelected {
                    case .house:
                        HomeView()
                    case .square:
                        downloadView(selectedImage: selectedImage, selectedLang: selected)
                    case .folder:
                        Saved()

                    }
                }
                .navigationTitle("TranslateMe")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showMenu.toggle()
                        }) {
                            Image(systemName: showMenu ? "text.justify" : "text.justify")
                                .resizable()
                                .foregroundColor(showMenu ? .black : .black)
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                TabBar(selectedTab: $tabSelected)
            }

            if showMenu {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea(.all)
                    MenuView()
                        .frame(width: UIScreen.main.bounds.width * 1.1, height: UIScreen.main.bounds.height, alignment: .leading)
                        .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width * 0.7)
                        .animation(.spring(), value: showMenu)
                }
                .onTapGesture {
                    showMenu = false
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


