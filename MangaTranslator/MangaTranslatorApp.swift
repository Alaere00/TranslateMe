//
//  MangaTranslatorApp.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/29/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

import Foundation


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    return true
  }
}

@main
struct TranslateMeApp: App {
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
        
    }
    init(){
        FirebaseApp.configure()

    }
}

extension UIColor {
    static var customColor: UIColor {
        return UIColor(red: 0.27, green: 0.57, blue: 1.00, alpha: 1.0)
    }
}



