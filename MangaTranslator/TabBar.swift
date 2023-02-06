//
//  TabBar.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 2/12/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case square
    case folder
}

struct TabBar: View {
    @State private var selectedImage: UIImage?
    @State var lang = "English"
    @Binding var selectedTab : Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    private var tabView: some View {
        switch selectedTab {
        case .house:
            return AnyView(HomeView())
        case .square:
            return AnyView(downloadView(selectedImage: selectedImage, selectedLang: lang))
        case .folder:
            return AnyView(Saved())
        }
    }
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .foregroundColor(.white)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .font(.system(size: 30))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 50)
            .background(Color("cornflower"))
            .ignoresSafeArea(.all)

        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.house))
    }
}
