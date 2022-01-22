//
//  PasswordInputView.swift
//  Message
//
//  Created by chase morgan on 1/21/22.
//

import SwiftUI

struct PasswordInputView: View {
        @Binding private var text: String
        @State private var isSecured: Bool = true
        
        init(_ title: String, text: Binding<String>) {
            self._text = text
        }
        
        var body: some View {
            ZStack(alignment: .trailing) {
                if isSecured {
                    SecureField("password", text: $text).padding().background(Color(UIColor.lightGray)).cornerRadius(15)
                } else {
                    TextField("password", text: $text).padding().background(Color(UIColor.lightGray)).cornerRadius(15)
                }
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye").padding()
                        .accentColor(.gray)
                }
            }
        }
}


