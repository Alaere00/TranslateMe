//
//  MenuView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/30/23.
//



import SwiftUI

struct MenuView: View {
    let gradient = LinearGradient(gradient: Gradient(colors: [.green, Color("AccentColor")]), startPoint: .top, endPoint: .bottom)
    
    var menuItems : [String:Any] = [(name: "Bookmark", imageName: "bookmark", destination: Bookmark()), (name: "Settings", imageName: "settings", destination: Settings()), (name: "Save", imageName: "save", destination: SaveView())]
    
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.title)
                .foregroundColor(.black)
            
            Divider()
                .frame(width: 200, height: 2)
                .background(Color.white)
                .padding(.horizontal, 16)
            
            
            VStack(alignment: .leading, spacing: 16) {
                Link(destination: URL(string: "https://apple.com")!){
                    Text("Apple")
                        .padding()
                
                }
                NavigationLink(destination: Settings()){
                    Image("settings")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Settings")
                }
                    
            }
            .font(.title)
            .foregroundColor(.black)
            
            Spacer()
        }
        
        .padding(32)
        .background(gradient)
        .edgesIgnoringSafeArea(.bottom)
    }
}





struct Settings: View {
var body: some View {
VStack {
Text("My settings are not fully configured, but in the future you will be able to make changes")
}
}
}

struct SaveView: View {
var body: some View {
VStack {
Text ("Here you willl be able to save all of the images you have")
}
}
}

struct Bookmark: View {
var body: some View {
VStack {
Text ("Here you willl be able to save all of the images you have")
}
}
}



struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    MenuView()
  }
}
