//
//  MainPageView.swift
//  Message
//
//  Created by chase morgan on 1/20/22.
//

import SwiftUI

struct MainPageView: View {
    @State private var errorText = ""
    @ObservedObject var loggedIn: LoggedIn
    @ObservedObject var userDetails: UserDetails = UserDetails()
    @State var currentUser = FireBaseAuth.getEmail()!
    var body: some View {
        VStack{
            Text("Current User: \(currentUser)")
            ChatView(userDetails: userDetails)
            
            
            
            
            
            
        }.navigationBarTitle("Messages",displayMode: .inline)
            .navigationBarItems(leading:
                            HStack {
                NavigationLink(destination: ProfileView(loggedIn: loggedIn,userDetails: userDetails)){
                                        Image(systemName: "square.and.pencil")
                    
                                    }.foregroundColor(Color(.cyan))
                            }, trailing:
                            HStack {
                                NavigationLink(destination: ProfileView(loggedIn: loggedIn,userDetails: userDetails)){
                                        Image(systemName: "person")
                    
                                        }.foregroundColor(Color(.cyan))
                                })
                        }
}

struct Convo{
    var senderUserName: String
}

private func fetchConvos() -> [Convo]{
    let convos: [Convo] = []
    
    return convos
}

