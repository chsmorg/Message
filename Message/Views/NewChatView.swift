//
//  NewChatView.swift
//  Message
//
//  Created by chase morgan on 1/20/22.
//

import SwiftUI

struct NewChatView: View {
    var body: some View {
        Form{
            Section(header: Text("Users")){
                    
                
            }
        }
    }
}

struct UserView{
    var userName: String
    var body: some View{
        HStack {
                Text(userName)
                Spacer()
                Button(action: {
                
            
            }, label: {
                Image(systemName: "plus.message").foregroundColor(.cyan)
            })
            }
    }
}


