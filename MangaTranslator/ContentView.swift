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
    @State private var tabSelected: Tab = .house
    @State var selected : String = "English"
    
    
    
    var body: some View {
        ZStack {
            NavigationView {
                TabView(selection: $tabSelected) {
                    switch tabSelected {
                    case .house:
                        HomeView()
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
                                .foregroundColor(showMenu ? .black : .white)
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
        .navigationBarModifier(backgroundColor: UIColor.customColor, foregroundColor:UIColor.white, largeTextAttributesColor: UIColor.black ,hideseperator: false)

    }
}

struct NavigationBarCustomModifier:ViewModifier{
    
    init(backgroundColor: UIColor, foregroundColor:UIColor, tintColor: UIColor? = nil,hideseperator: Bool = false){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        if hideseperator {
            UINavigationBar.appearance().tintColor = .black
        }
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

    }
    
    func body(content: Content) -> some View {
        content
    }
}
extension UIColor {
    static var customColor: UIColor {
        return UIColor(red: 0.27, green: 0.57, blue: 1.00, alpha: 1.0)
    }
}

extension View{
    func navigationBarModifier(backgroundColor: UIColor, foregroundColor:UIColor, largeTextAttributesColor: UIColor, tintColor: UIColor? = nil,hideseperator: Bool = false)-> some View{
        self.modifier(NavigationBarCustomModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, hideseperator: hideseperator))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


