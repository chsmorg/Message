//
//  DBManager.swift
//  Message
//
//  Created by chase morgan on 1/21/22.
//

import Foundation
import FirebaseDatabase

final class DBManager{
    static let shared = DBManager()
    private let database = Database.database().reference()
    
    
}
//account managment
extension DBManager{
    public func emailValidation(with email: String, completion: @escaping ((Bool)-> Void)){
        let userEmail = email.replacingOccurrences(of: ".", with: "-")
        
        database.child(userEmail).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != "null" else {
                completion(false)
                return
            }
            completion(true)
        })
        
    }
    /// adds new user to database
    public func newUser(with user: MessageUser){
        database.child(user.userEmail).setValue([
            "username": user.username,
            "email": user.email
        ])
    }
}

struct MessageUser {
    let username: String
    let email: String
    
    var userEmail:String{
        
        let userEmail = email.replacingOccurrences(of: ".", with: "-")
        return userEmail
    }
    
}
