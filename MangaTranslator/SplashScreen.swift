//
//  SplashScreen.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/29/23.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var angle: Double = 0
    @State var size = 0.4
    @State var opacity = 0.6
    @State var isUserCurrentlyLoggedOut : Bool = true
    let gradient = LinearGradient(gradient: Gradient(colors: [.white, Color("cornflower")]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {

            ZStack {
                gradient.ignoresSafeArea()
                
                if isActive {
                    NavigationView {
                            LoginView()
                        }
                    
                } else {
                    VStack {
                        Image("manga")
                            .resizable()
                            .frame(width: 160, height: 140)
                        Text("TranslateMe")
                            .font(.system(size: 24))
                        
                    }
                    
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }

                
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    
                    }
                }
            }
            
        }
    }




struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
