//
//  MessageApp.swift
//  Message
//
//  Created by chase morgan on 1/20/22.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

@main
struct MessageApp: App {
    init(){
        FirebaseApp.configure()
        print("1")
        }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
}
