//
//  Saved.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/1/23.
//

import SwiftUI

struct Saved: View {
    @State private var showMenu = false
    var body: some View {
        Button(action: {
            self.showMenu.toggle()
        }) {
            Image(systemName: "ellipsis")
                .imageScale(.large)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
        .background(Color.secondary)
        .clipShape(Circle())
        .sheet(isPresented: $showMenu){
            Button(action: {
                
            }){
                Text("Save")
            }
            Button(action: {
                
            }){
                Text("Delete")
            }
        }
    }
}

struct Saved_Previews: PreviewProvider {
    static var previews: some View {
        Saved()
    }
}
