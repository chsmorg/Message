//
//  UserDetails.swift
//  Message
//
//  Created by chase morgan on 1/20/22.
//

import Foundation


class UserDetails: ObservableObject {
    @Published var notificationsEnabled: Bool = true
    @Published var preview: Bool = true
    @Published var userEmail: String = FireBaseAuth.getEmail() ?? ""
    @Published var userID: String = FireBaseAuth.getUserID() ?? ""
    @Published var username: String = FireBaseAuth.getUserName() ?? ""
}
