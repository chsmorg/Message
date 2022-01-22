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

@main
struct MessageApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
