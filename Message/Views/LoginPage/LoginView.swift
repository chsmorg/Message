//
//  LoginView.swift
//  Message
//
//  Created by chase morgan on 1/20/22.
//

import SwiftUI
import GoogleSignIn
import Firebase

enum Field: Hashable{
    case username
    case password
    case email
}




struct LoginView: View {
    //@ObservedObject var userDetails: UserDetails
    @ObservedObject var loggedIn: LoggedIn
    @FocusState private var focusedField: Field?
    @State private var focusedFieldStateVar: Field?
    @State private var emailInput = ""
    @State private var passwordInput = ""
    @State private var errorText = ""
    @State private var validEmail: Bool = false
    
    
    
    var body: some View {
        
        VStack{
            VStack(alignment: .center, spacing: 10){
                
                
                TextField("Email", text: $emailInput)
                    .focused($focusedField, equals: .email).padding().background(Color(UIColor.lightGray)).cornerRadius(15).autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        focusedField = .password
                    }
                PasswordInputView(passwordInput, text: $passwordInput).focused($focusedField, equals: .password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
       }.padding()
                   
           // colorScheme == .dark ? Color(UIColor.lightText) : Color(UIColor.darkText)
            HStack{
                
                Button(action: {
                    if(!emailInput.isEmpty && !passwordInput.isEmpty ){
                        FireBaseAuth.authenticate(withEmail: emailInput, password: passwordInput) {authResult in
                            switch authResult {
                            case .failure(let error):
                                errorText = error.localizedDescription
                            case .success( _):
                                print("Account Login successful")
                                loggedIn.loggedIn = true
                            }
                        }
                    }
                    else{
                        errorText = "Enter account information to sign in"
                    }
                    
                    
                    
                },label: {
                    Text("Login").padding()
                        .foregroundColor(.black)
                        .background (.cyan)
                        .cornerRadius(15)
                        

                }).padding()
               
            
            }
            Text(errorText).font(.system(size: 15,
                                         weight: .regular,
                                         design: .rounded)).foregroundColor(.red)
            Spacer()
            HStack{
                VStack{
                    Divider()
                }
                Text("Or Continue With").font(.system(size:15,
                                                      weight: .regular,
                                                      design: .rounded))
                                        
                VStack{
                    Divider()
                }
            }
            HStack{
                Button(action: {
                    handleGoogleLogin()
                },label: {
                    Image("google").resizable().frame(width: 50, height: 50).scaledToFit()
                        

                }).padding()
            }
            HStack{
                Text("Don't have an account?")
                NavigationLink(destination: RegView()){
                    Text("Sign Up")
                }
            }.padding()
            Text("Version 0.0.0.1").font(.system(size:8,
                                                 weight: .regular,
                                                 design: .rounded)).foregroundColor(Color(UIColor.lightGray))
            
        }.navigationBarTitle("LOGIN",displayMode: .inline)
        
    }
    
    
    func handleGoogleLogin(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()){[self] user, error in
            if let error = error {
                errorText = error.localizedDescription
                return
              }

              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){
                result, err in
                if let error = err{
                    errorText = error.localizedDescription
                    return
                }
                else{
                    
                    DBManager.shared.emailValidation(with: (result?.user.email)!, completion: { authResult in
                        
                        if(authResult == true){
                           validEmail = true
                        }
                        else{
                            validEmail = false
                        }
                    })
                    if(!validEmail){
                        let userEmail = result?.user.email!.replacingOccurrences(of: ".", with: "-")
                        //print(userEmail)
                       // print(result?.user.displayName)
                        DBManager.shared.newUser(with: MessageUser(username: (result?.user.displayName)!, email: userEmail!))
                        
                    }
                    loggedIn.loggedIn = true
                    
                }
                
            }

        }
        
    }
}
extension View{
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
        
    }
}
