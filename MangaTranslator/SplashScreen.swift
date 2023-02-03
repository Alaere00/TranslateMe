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
    
    let gradient = LinearGradient(gradient: Gradient(colors: [.green, Color("AccentColor")]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        if isActive {
            LoginView()
        } else {
            VStack {
                VStack {
                    Image("balloon")
                        .font(.system(size: 160))
                        .rotationEffect(.degrees(angle))
                        .onAppear(){
                            withAnimation(.easeInOut(duration: 3)){
                                self.angle += 360
                            }
                            
                        }.background(gradient).cornerRadius(75)
                    Text("TranslateMe")
                        .font(Font.custom("Inter-SemiBold", size: 20))
                        .padding()
                }
                
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
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
