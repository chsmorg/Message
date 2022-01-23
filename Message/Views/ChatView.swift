//
//  ChatView.swift
//  Message
//
//  Created by chase morgan on 1/22/22.
//

import SwiftUI
import MessageKit

struct Message {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var text: String
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

func setBubblePos(senderId: String, userId: String) -> BPosition{
    if(senderId == userId){
        return BPosition.right
    }
    else{
        return BPosition.left
    }
        }

func getBubbleColor(senderID: String, userId: String)-> Color{
    let pos = setBubblePos(senderId: senderID, userId: userId)
    
    if (pos == BPosition.right){
        return Color(uiColor: .link)
    }
    else{
        return Color(uiColor: .lightGray)
    }
}


private var sender: Sender = Sender(senderId: "1", displayName: "test")

struct ChatView: View {
    @ObservedObject var userDetails: UserDetails
    @State private var messages: [Message] = [Message(sender: sender, messageId: "1", sentDate: Date(), text: ("testing message"))]
    @State var model: String = ""
    
    
    var body: some View {
        GeometryReader { geo in
            
            
                  VStack {
                      //setBubblePos(senderId: sender.senderId, userId: userDetails.userID)
                      // getBubbleColor(senderID: sender.senderId, userId: userDetails.userID)
                      //MARK:- ScrollView
                      CustomScrollView(scrollToEnd: true) {
                          LazyVStack {
                              ForEach(0..<messages.count, id:\.self) { index in
                                  ChatBubble(position: setBubblePos(senderId: messages[index].sender.senderId, userId: userDetails.userID) , color: getBubbleColor(senderID: messages[index].sender.senderId, userId: userDetails.userID)){
                                      let message = messages[index].text
                                      
                                      Text(message)
                                  }
                              }
                          }
                      }.padding(.top)
                      
                      
                      //MARK:- text editor
                      HStack {
                          ZStack {
                              TextEditor(text: $model)
                              RoundedRectangle(cornerRadius: 10)
                                  .stroke()
                                  .foregroundColor(.gray)
                          }.frame(height: 40)
                          
                          Button("send") {
                              if model != "" {
                                  messages.append(Message(sender: Sender(senderId: userDetails.userID, displayName: userDetails.username), messageId: "1", sentDate: Date(), text: model))
                                  model = ""
                              }
                          }
                      }.padding()
                  }.onTapGesture{
                      UIApplication.shared.endEditing()
                  }
              }
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


