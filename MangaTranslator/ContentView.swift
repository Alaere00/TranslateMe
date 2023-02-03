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

//let menuItems = [Menu(name: "Bookmark", imageName: "bookmark", color: .black),Menu(name: "Save", imageName: "save", color:.black), Menu(name: "Settings", imageName: "settings", color:.black), Menu(name: "Logout", imageName: "logout", color:.black)]


struct ContentView: View {
    
    @State private var showMenu = false
 
    var body: some View {
        ZStack {
            NavigationView {
                TabView {
                    HomeView()
                        .tabItem {Text("Home")}
                        .tag(1)
                    Saved()
                        .tabItem {Text("Saved")}
                        .tag(2)
                    Reading()
                        .tabItem {Text("Reading")}
                        .tag(3)

            }
  
                .navigationTitle("TranslateMe")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showMenu.toggle()
                    } label: {
                        Image(systemName: showMenu ? "text.justify" : "text.justify")
                            .resizable()
                            .foregroundColor(showMenu ? .green : .green)
                    }
                        
                }
            
            }.background(Color("AccentColor"))
                         
        }
                if showMenu {
                    GeometryReader { _ in
                        HStack {
                            VStack {
                                MenuView()
                                    .offset(x: showMenu ? 0: 100)
                                    .animation(.spring(), value: showMenu)
                            }
                        }
                        .onTapGesture {
                            showMenu = false
                        }
                    }.background(Color.black.opacity(0.5))
                }
            }.navigationBarBackButtonHidden(true)
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


