//
//  MenuView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/30/23.
//



import SwiftUI
import FirebaseAuth

let gradient = LinearGradient(gradient: Gradient(colors: [.green, Color("AccentColor")]), startPoint: .top, endPoint: .bottom)

struct MenuView: View {
    
    
    @Environment(\.dismiss) private var dismiss
    @State private var showLogoutScreen = false
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.title)
                .foregroundColor(.black)
            
            Divider()
                .frame(width: 200, height: 2)
                .background(Color.black)
                .padding(.horizontal, 16)
            
            VStack(alignment: .leading, spacing: 40) {
                
                    NavigationLink(destination: Bookmark()) {
                        HStack {
                            Image(systemName: "bookmark")
                            Text("Bookmark")
                        }
                    }
                    
                    NavigationLink(destination: Favorites()) {
                        HStack {
                            Image(systemName: "star")
                            Text("Favorites")
                        }
                    }
                NavigationLink(destination: Settings()) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                    
                    Link(destination: URL(string: "https://www.viz.com/")!) {
                        HStack {
                            Image(systemName: "safari")
                            Text("Websites")
                            
                        }
                    }
                    Spacer()
            }
            Button(action: {
                self.signOut()
                self.showLogoutScreen = true
            }) {
                VStack {
                    Divider()
                        .frame(width: 200, height: 2)
                        .background(Color.black)
                        .padding(.horizontal, 16)
                    Image("logout")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Sign out")
                        .foregroundColor(.black)
                }
                    
                }
       
            .sheet(isPresented: $showLogoutScreen) {
    
                LogoutScreen()
            
    
                    
            }
            .padding(.bottom, 20)
        }
        .padding(2)
        .background(gradient)
        .foregroundColor(.black)
    }
    private func signOut() {
        do {
            try Auth.auth().signOut()
            print("Successfully logged out")
            dismiss()
        } catch {
            print("Error, could not sign out")

        }
    }

}

struct LogoutScreen: View {
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, Color("AccentColor")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            Text("You have successfully signed out")
        }
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
            Text ("Bookmark single images or collections, can also delete")
        }
    }
}

struct Favorites: View {
    var body: some View {
        VStack {
            Text ("Users will be able to store their favorites in this location")
        }
    }
}



struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    MenuView()
  }
}
