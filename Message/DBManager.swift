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
           // print(snapshot.value  as? NSDictionary)
           // print(userEmail)
            let value = snapshot.value as? NSDictionary
            if(value == nil){
                completion(true)
                
            }
            else{
                completion(false)
                
            }
            return
        })
        
    }
    /// adds new user to database
    public func newUser(with user: MessageUser){
        database.child(user.userEmail).setValue([
            "username": user.username,
            "email": user.email
        ])
        
    }
    public func insertUser(with user: MessageUser, completion: @escaping ((Bool)-> Void)){
        self.database.child("users").observeSingleEvent(of: .value, with: {snapshot in
            
            if var usersCollection = snapshot.value as? [[String: String]] {
                let newElement = ["username": user.username,
                                  "email": user.userEmail
                                 ]
                usersCollection.append(newElement)
                
                self.database.child("users").setValue(usersCollection, withCompletionBlock: {
                    error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                })
            }
            else{
                let newCollection: [[String: String]] =
                    [["username": user.username,
                     "email": user.userEmail
                    ]]
                    self.database.child("users").setValue(newCollection, withCompletionBlock: {
                        error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                    })
                
            }
            completion(true)
            
            
        })
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
