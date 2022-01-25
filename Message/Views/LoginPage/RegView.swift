//
//  RegView.swift
//  Message
//
//  Created by chase morgan on 1/20/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegView: View {
    @FocusState private var focusedField: Field?
    @State private var focusedFieldStateVar: Field?
    @State private var emailInput = ""
    @State private var usernameInput = ""
    @State private var passwordInput = ""
    @State private var errorText = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            VStack(alignment: .center, spacing: 10){
                
                
                TextField("Email", text: $emailInput)
                    .focused($focusedField, equals: .email).padding().background(Color(UIColor.lightGray)).cornerRadius(15).autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                    .onSubmit {
                        focusedField = .username
                    }
                TextField("UserName", text: $usernameInput)
                    .focused($focusedField, equals: .username).padding().background(Color(UIColor.lightGray)).cornerRadius(15).autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        focusedField = .password
                    }
                PasswordInputView(passwordInput, text: $passwordInput).disableAutocorrection(true).autocapitalization(.none).focused($focusedField, equals: .password)
            }.padding()
            HStack{
                
                Button(action: {
                    if(!emailInput.isEmpty && !usernameInput.isEmpty && !passwordInput.isEmpty){
                    DBManager.shared.emailValidation(with: emailInput, completion: { authResult in
                        print("auth result = \(authResult)")
                        if(authResult == true){
                            FireBaseAuth.createUser(withEmail: emailInput, username: usernameInput, password: passwordInput) {authResult in
                                switch authResult {
                                case .failure(let error):
                                    errorText = error.localizedDescription
                                case .success( _):
                                    print("Account creation successful")
                                    let account = MessageUser(username: usernameInput, email: emailInput)
                                    DBManager.shared.newUser(with: account)
                                    DBManager.shared.insertUser(with: account, completion: { authResult in
                                        
                                        if(authResult == true){
                                            
                                        }
                                        else{
                                            errorText = "Error creating account."
                                            return
                                        }
                                    })
                                        
                                    
                                    self.presentationMode.wrappedValue.dismiss()
                            }
                            }
                        }
                        else{
                            errorText = "Email has already been taken."
                        
                        }
                    })
                    }
                    else{
                        errorText = "Fill all boxs to create an account."
                    }
                    
                    
                },label: {
                    Text("Create Account").padding()
                        .foregroundColor(.black)
                        .background (.cyan)
                        .cornerRadius(15)
                        

                }).padding()
               
            }
            Text(errorText).font(.system(size: 15,
                                         weight: .regular,
                                         design: .rounded)).foregroundColor(.red)
        }
    }
}

struct RegView_Previews: PreviewProvider {
    static var previews: some View {
        RegView()
    }
}
