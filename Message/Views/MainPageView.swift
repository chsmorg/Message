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
    @State var currentUser = FireBaseAuth.getEmail()!
    var body: some View {
        VStack{
            Button(action: {
                    FireBaseAuth.logout(){authResult in
                        switch authResult {
                        case .failure(let error):
                            errorText = error.localizedDescription
                        case .success( _):
                            print("Account Login successful")
                            loggedIn.loggedIn = false
                        }
                    }  
            },label: {
                Text("Logout").padding()
                    .foregroundColor(.black)
                    .background (.cyan)
                    .cornerRadius(15)
                    

            }).padding()
            Text("Current User: \(currentUser)")
        }
       
    }
}

