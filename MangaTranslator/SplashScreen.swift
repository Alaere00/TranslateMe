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
    @State var isUserCurrentlyLoggedOut : Bool = false

    var body: some View {
        VStack {
        if isActive {
            LoginView()
            
        } else {
            VStack {
                    Image("")
                        .resizable()
                        .frame(width: 150, height: 130)
                        .rotationEffect(.degrees(angle))
                        .onAppear(){
                            withAnimation(.easeInOut(duration: 3)){
                                self.angle += 360
                            }
                            
                        }
                    Text("TranslateMe")
                        .font(Font.custom("Inter-SemiBold", size: 20))
                        .padding()
                
            }.background(Color("cornflower"))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                    }
                }
            }
            
        }.background(Color("cornflower"))
    }
}



struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
