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
    @State private var vaildEmail: Bool = false
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
                    DBManager.shared.emailValidation(with: emailInput, completion: { authResult in
                        print(authResult)
                        if(authResult == true){
                            vaildEmail = true
                        }
                        else{
                            vaildEmail = false
                            errorText = "Email has already been taken"
                        
                        }
                    })
                    if(vaildEmail){
                        if(!emailInput.isEmpty && !usernameInput.isEmpty && !passwordInput.isEmpty){
                            FireBaseAuth.createUser(withEmail: emailInput, username: usernameInput, password: passwordInput) {authResult in
                                switch authResult {
                                case .failure(let error):
                                    errorText = error.localizedDescription
                                case .success( _):
                                    print("Account creation successful")
                                    DBManager.shared.newUser(with: MessageUser(username: usernameInput, email: emailInput))
                                        
                                    
                                    self.presentationMode.wrappedValue.dismiss()
                            }
                            }
                        }
                        else{
                            errorText = "Fill all fields to create a new account"
                        }
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
