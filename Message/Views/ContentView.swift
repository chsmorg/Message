//
//  ContentView.swift
//  Message
//
//  Created by chase morgan on 1/20/22.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var userDetails: UserDetails = UserDetails()
    @ObservedObject var loggedIn: LoggedIn = LoggedIn()
    
    var body: some View {
        if (!FireBaseAuth.validateAuth()){
            NavigationView{
                LoginView(loggedIn: loggedIn)
            }
            
        }
        else{
            NavigationView{
                MainPageView(loggedIn: loggedIn)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
