//
//  ProfileView.swift
//  Message
//
//  Created by chase morgan on 1/20/22.
//

import SwiftUI


struct ProfileView: View {
    @ObservedObject var loggedIn: LoggedIn
    @ObservedObject var userDetails: UserDetails
    var body: some View {
        Form{
            Section(header: Text("ACCOUNT")){
                    HStack {
                            Text("Email")
                            Spacer()
                        Text(userDetails.userEmail)
                        }
                HStack {
                        Text("Username")
                        Spacer()
                    Text(userDetails.username)
                    }
                HStack {
                        Text("UserID")
                        Spacer()
                    Text(userDetails.userID)
                    }
                
                
            }
            

            Section(header: Text("NOTIFICATIONS")) {
                Toggle(isOn: $userDetails.notificationsEnabled) {
                    Text("Enabled")
                }.tint(.cyan)
                Toggle(isOn: $userDetails.preview) {
                    Text("Preview Message")
                }.tint(.cyan)
                
            }
            
            Section {
                    Button(action: {
                        FireBaseAuth.logout(){authResult in
                            switch authResult {
                            case .failure(_):
                                print("logout failed")
                            case .success( _):
                                print("Account Login successful")
                                loggedIn.loggedIn = false
                            }
                        }
                                }) {
                                    Text("Logout").foregroundColor(Color(.cyan))
                                }
                            }
        }.navigationTitle("Settings")
    }
}


